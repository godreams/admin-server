class Coach < ApplicationRecord
  belongs_to :user
  belongs_to :fellow
  has_one :national_finance_head, through: :fellow
  has_many :volunteers
  has_many :donations, through: :volunteers

  validates_presence_of :user, :fellow
end
