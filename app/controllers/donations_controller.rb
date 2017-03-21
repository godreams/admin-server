class DonationsController < ApplicationController
  # GET /donations
  def index
    @donations = current_user_role.donations.order('donations.created_at DESC')
    filter_donations
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
    authorize Donation.new
    @form = Donations::CreateForm.new(donation)

    if @form.validate(params[:donations_create])
      @form.save!(current_volunteer)
      flash[:notice] = 'Donation has been successfully recorded!'
      redirect_to donations_path
    else
      render 'new'
    end
  end

  # PATCH /donations/:id
  def update
    updater = current_national_finance_head || current_fellow || current_coach
    donation = Donation.find(params[:id])
    Donations::UpdateService.new(donation).update(updater, params)
    render json: { success: true, donation: donation.reload }
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
