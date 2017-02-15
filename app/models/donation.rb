class Donation < ApplicationRecord
  belongs_to :volunteer
  has_many :approvals

  validates_presence_of :name, :email, :phone, :amount, :volunteer

  def approved?
    approvals.present?
  end

  def status_string
    Donations::StatusService.new(self).status_string
  end

  def approvable?(user_role)
    raise 'Unexpected approvable call' unless self.in? user_role.donations

    # volunteers are never allowed approvals
    return false if user_role.is_a? Volunteer

    latest_approval = approvals.order(:created_at).last

    # donation was never approved by any one
    return true if latest_approval.blank?

    case latest_approval.approver.class.name
      when 'NationalFinanceHead' then false
      when 'Fellow' then user_role.is_a? NationalFinanceHead
      when 'Coach' then user_role.class.name.in? %w(NationalFinanceHead Fellow)
      when 'Volunteer' then user_role.class.name.in? %w(NationalFinanceHead Fellow Coach)
      else
        raise
    end
  end
end
