class NationalFinanceHead < ApplicationRecord
  belongs_to :user
  has_many :fellows, dependent: :restrict_with_error
  has_many :coaches, through: :fellows
  has_many :volunteers, through: :coaches
  has_many :donations, through: :volunteers
  has_many :approvals, as: :approver
  delegate :name, :email, :phone, to: :user
end
