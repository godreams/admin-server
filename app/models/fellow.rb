class Fellow < ApplicationRecord
  belongs_to :user
  belongs_to :national_finance_head
  has_many :coaches
  has_many :volunteers, through: :coaches
  has_many :donations, through: :volunteers
  has_many :approvals, as: :approver
end
