module Donations
  class StatusService
    include Translatable

    def initialize(donation)
      @donation = donation
    end

    def status_string
      return t('donations.status_service.approval_pending') unless @donation.approved?
      latest_approval = @donation.approvals.order('created_at DESC').first
      t("donations.status_service.approved_by.#{latest_approval.approver.class.name.underscore}")
    end
  end
end
