module Donations
  class DestroyService
    def initialize(donation)
      @donation = donation
    end

    def destroy(destroyer)
      raise Donations::DeleteNotAllowedException if destroyer.blank?
      @donation.destroy!
    end
  end
end
