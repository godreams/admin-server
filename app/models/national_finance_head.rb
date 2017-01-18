class NationalFinanceHead < ApplicationRecord
  belongs_to :user
  has_many :fellows
  has_many :coaches, through: :fellows
  has_many :volunteers, through: :coaches
  has_many :donations, through: :volunteers

  validates_presence_of :user
end
