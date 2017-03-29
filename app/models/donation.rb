class Donation < ApplicationRecord
  has_paper_trail ignore: [:updated_at], on: [:update, :destroy]

  belongs_to :volunteer
  has_many :approvals
  has_one :city, through: :volunteer
  has_one :coach, through: :volunteer
  has_one :fellow, through: :coach
  has_one :national_finance_head, through: :fellow

  validates :name, presence: true
  validates :email, presence: true
  validates :phone, presence: true
  validates :amount, presence: true

  scope :pending, -> { joins('LEFT JOIN approvals ON donations.id = approvals.donation_id').where(approvals: { id: nil }) }
  scope :verified, -> { joins(:approvals).where(approvals: { approver_type: 'NationalFinanceHead' }) }
  scope :processing, -> { where.not(id: pending.references(:approvals)).where.not(id: verified) }

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
