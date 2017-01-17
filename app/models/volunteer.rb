class Volunteer < ApplicationRecord
  belongs_to :user
  belongs_to :coach
  has_many :donations
end
