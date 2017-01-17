class Fellow < ApplicationRecord
  belongs_to :user
  belongs_to :national_finance_head
  has_many :coaches
end
