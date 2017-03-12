class DonationsController < ApplicationController
  def index
    @donations = current_user_role.donations.order('created_at DESC')
  end

  def show
    @donation = Donation.find(params[:id])
  end

  # POST /donations
  def create
    raise Donations::VolunteerRequiredException if current_volunteer.blank?

    form = Donations::CreateForm.new(Donation.new)

    if form.validate(params)
      form.save!(current_volunteer)
      @donation = form.model
    else
      raise ValidationFailureException.new(form)
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
end
