class DonationPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    index?
  end

  def create?
    user&.volunteer?
  end

  def update?
    raise 'This should be allowed for Coaches, Fellows and NFP-s above the owning volunteer.'
  end

  # Whether user can approve a donation depends on the level of the last approval - only higher-ups can approve
  # donations that have been approved by lower roles.
  def approve?
    return false if user.blank?

    role = user.dominant_role

    return false unless record.in?(role.donations)

    latest_approval = record.approvals.order(:created_at).last

    if latest_approval.present?
      case latest_approval.approver.class
        when NationalFinanceHead then
          false
        when Fellow then
          role.is_a?(NationalFinanceHead)
        when Coach then
          role.class.in?([NationalFinanceHead, Fellow])
        else
          role.class.in?([NationalFinanceHead, Fellow, Coach])
      end
    else
      role.class.in?([NationalFinanceHead, Fellow, Coach])
    end
  end
end
