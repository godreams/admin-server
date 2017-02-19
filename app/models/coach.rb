class Coach < ApplicationRecord
  belongs_to :user
  belongs_to :fellow
  has_one :national_finance_head, through: :fellow
  has_many :volunteers
  has_many :donations, through: :volunteers
end
