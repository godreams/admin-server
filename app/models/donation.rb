class Donation < ApplicationRecord
  belongs_to :volunteer
  has_many :approvals

  validates_presence_of :name, :email, :phone, :amount, :volunteer

  def approved?
    approvals.present?
  end
end
