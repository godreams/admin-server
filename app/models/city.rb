class City < ApplicationRecord
  has_many :fellows
  has_many :coaches, through: :fellows
  has_many :volunteers, through: :coaches
  has_many :donations, through: :volunteers

  validates :name, presence: true, uniqueness: true
end