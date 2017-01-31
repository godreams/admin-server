class DonationsController < ApplicationController
  def index
    @donations = current_user_role.donations
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
      render json: { success: true, donation: form.model }
    else
      raise Donations::ValidationFailureException.new(form)
    end
  end
end
