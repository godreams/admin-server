module Donations
  class ApprovalService
    def initialize(donation)
      @donation = donation
    end

    def approve(approver)
      raise Donations::AlreadyApprovedException unless @donation.approvable?(approver)
      raise Donations::ApproveNotAllowedException if approver.blank?
      Approval.create!(donation: @donation, approver: approver)
    end
  end
end
