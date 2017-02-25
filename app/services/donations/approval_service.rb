module Donations
  class ApprovalService
    def initialize(donation)
      @donation = donation
    end

    def approve(approver)
      raise Donations::AlreadyApprovedException unless @donation.approvable?(approver)
      raise Donations::ApproveNotAllowedException if approver.blank?
      Approval.create!(donation: @donation, approver: approver)

      if approver.is_a?(NationalFinanceHead)
        Donations::ReceiptJob.perform_later(@donation)
      end
    end
  end
end
