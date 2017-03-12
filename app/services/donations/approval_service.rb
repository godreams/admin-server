module Donations
  class ApprovalService
    def initialize(donation, user)
      @donation = donation
      @user = user
    end

    def approve
      raise Donations::ApproveNotAllowedException unless DonationPolicy.new(@user, @donation).approve?

      Approval.create!(donation: @donation, approver: approver)

      if approver.is_a?(NationalFinanceHead)
        Donations::ReceiptJob.perform_later(@donation)
      end
    end

    private

    def approver
      @approver ||= @user.dominant_role
    end
  end
end
