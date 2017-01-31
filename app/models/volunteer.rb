class Volunteer < ApplicationRecord
  belongs_to :user
  belongs_to :coach
  has_one :fellow, through: :coach
  has_one :national_finance_head, through: :fellow
  has_many :donations

  validates_presence_of :user, :coach
end
