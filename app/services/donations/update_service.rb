module Donations
  class UpdateService
    def initialize(donation)
      @donation = donation
    end

    def update(updater, params)
      raise Donations::UpdateNotAllowedException if updater.blank?
      @donation.update!(update_params(params))
    end

    private

    def update_params(params)
      params.permit(:name, :email, :phone, :amount, :pan, :address)
    end
  end
end

