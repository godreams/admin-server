class City < ApplicationRecord
  has_many :fellows

  validates :name, presence: true, uniqueness: true
end