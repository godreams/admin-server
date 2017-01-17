class Coach < ApplicationRecord
  belongs_to :user
  belongs_to :fellow
  has_many :volunteers
end
