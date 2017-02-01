module Donations
  class ApprovalService
    def initialize(donation)
      @donation = donation
    end

    def approve(approver)
      raise Donations::ApproveNotAllowedException if approver.blank?

      # Do something to mark approval
    end
  end
end
