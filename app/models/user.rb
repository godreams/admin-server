class User < ApplicationRecord
  has_secure_password

  has_one :volunteer
  has_one :coach
  has_one :fellow
  has_one :national_finance_head

  validates_presence_of :name, :email, :phone
end
