class DonationsController < ApplicationController
  before_action :set_paper_trail_whodunnit

  # GET /donations
  def index
    @filter_form = Donations::FilterForm.new(OpenStruct.new)
    @filter_form.prepopulate(params[:donations_filter])

    donations = current_user_role.donations.order('donations.created_at DESC')
    @donations = Donations::FilterService.new(donations).filter(params[:donations_filter])

    respond_to do |format|
      format.html
      format.csv { render csv: @donations, filename: "donations_#{Time.now.strftime('%Y%m%d_%H%M%S')}" }
    end
  end

  # GET /donations/:id
  def show
    @donation = Donation.find(params[:id])
    authorize @donation
  end

  # GET /donations/new
  def new
    donation = Donation.new
    authorize donation
    @form = Donations::CreateForm.new(Donation.new)
  end

  # POST /donations
  def create
    donation = Donation.new
    authorize donation
    @form = Donations::CreateForm.new(donation)

    if @form.validate(params[:donation])
      @form.save(current_volunteer)
      flash[:notice] = 'Donation has been successfully recorded!'
      redirect_to donations_path
    else
      render 'new'
    end
  end

  # GET /donations/:id/edit
  def edit
    donation = Donation.find(params[:id])
    authorize donation
    @form = Donations::EditForm.new(donation)
  end

  # PATCH /donations/:id
  def update
    donation = Donation.find(params[:id])
    authorize donation
    @form = Donations::EditForm.new(donation)

    if @form.validate(params[:donation])
      @form.save
      flash[:notice] = 'Donation has been successfully updated!'
      redirect_to donation_path(donation)
    else
      render 'edit'
    end
  end

  # DELETE /donations/:id
  def destroy
    destroyer = current_national_finance_head || current_fellow
    donation = Donation.find(params[:id])
    Donations::DestroyService.new(donation).destroy(destroyer)
    render json: { success: true, donation: donation }
  end

  # POST /donations/:id/approve
  def approve
    donation = Donation.find(params[:id])
    authorize donation
    Donations::ApprovalService.new(donation, current_user).approve
    flash[:notice] = 'Your approval of the donation has been recorded.'
    redirect_back fallback_location: donations_path
  end

  # GET /donations/:id/receipt
  def receipt
    @donation = Donation.find(params[:id])
    raise Donations::ApprovalIncompleteException unless @donation.final_approval.present?
    @receipt_pdf = Base64.encode64(Donations::ReceiptPdf.new(@donation).build.render)
  end

  private

  def filter_donations
    return unless filter_applied?
    @donations = @donations.where(volunteer: Volunteer.find(params[:volunteer]))
  end

  def filter_applied?
    params[:volunteer].present?
  end
end
