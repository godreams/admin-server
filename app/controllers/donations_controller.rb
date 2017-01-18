class DonationsController < ApplicationController
  def index
    @donations = current_user_role.donations
  end

  def show
    @donation = Donation.find(params[:id])
  end
end
