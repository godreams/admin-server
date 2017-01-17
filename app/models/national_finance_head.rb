class NationalFinanceHead < ApplicationRecord
  belongs_to :user
  has_many :fellows
end
