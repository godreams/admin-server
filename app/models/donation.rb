class Donation < ApplicationRecord
  belongs_to :volunteer
  has_many :approvals

  validates :name, presence: true
  validates :email, presence: true
  validates :phone, presence: true
  validates :amount, presence: true

  def approved?
    approvals.present?
  end

  def final_approval
    approvals.find_by(approver_type: 'NationalFinanceHead')
  end

  def status_string
    Donations::StatusService.new(self).status_string
  end
end
