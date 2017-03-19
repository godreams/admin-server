class Volunteer < ApplicationRecord
  belongs_to :user
  belongs_to :coach
  has_one :fellow, through: :coach
  has_one :national_finance_head, through: :fellow
  has_many :donations, dependent: :restrict_with_error
  delegate :name, to: :user
end
