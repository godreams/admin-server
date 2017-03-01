class User < ApplicationRecord
  has_secure_password

  has_one :volunteer, dependent: :destroy
  has_one :coach, dependent: :destroy
  has_one :fellow, dependent: :destroy
  has_one :national_finance_head, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :phone, presence: true

  def approvals
    fellow.approvals.or(national_finance_head.approvals)
  end

  def roles_array
    [national_finance_head, fellow, coach, volunteer].map do |role|
      if role.present?
        role.class.name
      end
    end - [nil]
  end
end
