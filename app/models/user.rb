class User < ApplicationRecord
  has_secure_password

  has_one :volunteer
  has_one :coach
  has_one :fellow
  has_one :national_finance_head

  validates_presence_of :name, :email, :phone

  def approvals
    fellow.approvals.or(national_finance_head.approvals)
  end
end
