class Fellow < ApplicationRecord
  belongs_to :user
  belongs_to :national_finance_head
  has_many :coaches, dependent: :restrict_with_error
  has_many :volunteers, through: :coaches
  has_many :donations, through: :volunteers
  has_many :approvals, as: :approver
  belongs_to :city

  delegate :name, :email, :phone, to: :user
end
