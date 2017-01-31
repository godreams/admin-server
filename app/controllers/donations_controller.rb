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
  end
end
