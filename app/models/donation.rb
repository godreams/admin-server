class Donation < ApplicationRecord
  belongs_to :volunteer

  validates_presence_of :name, :email, :phone, :amount, :volunteer
end
