module Donations
  class StatusService
    def initialize(donation)
      @donation = donation
    end

    def status_string
      return 'Pending Coach Approval' unless @donation.approved?

      latest_approval = @donation.approvals.order('created_at DESC').first
      approval_string(latest_approval.approver)
    end

    private

    def approval_string(approver)
      case approver.class.name
        when 'Coach'
          'Approved by your Coach'
        when 'Fellow'
          'Approved by your Fellow'
        when 'NationalFinanceHead'
          'Approved by your National Finance Head'
        else
          raise
      end
    end
  end
end
