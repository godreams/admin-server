class NationalFinanceHead < ApplicationRecord
  belongs_to :user
  has_many :fellows
  has_many :coaches, through: :fellows
  has_many :volunteers, through: :fellows

  validates_presence_of :user
end
