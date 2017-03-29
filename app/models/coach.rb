class Coach < ApplicationRecord
  belongs_to :user
  belongs_to :fellow
  has_one :national_finance_head, through: :fellow
  has_many :volunteers, dependent: :restrict_with_error
  has_many :donations, through: :volunteers
  has_one :city, through: :fellow
  delegate :name, :email, :phone, to: :user
end
