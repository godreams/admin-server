class Fellow < ApplicationRecord
  belongs_to :user
  belongs_to :national_finance_head
  has_many :coaches
  has_many :volunteers, through: :coaches

  validates_presence_of :user, :national_finance_head
end
