class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

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

  def self.with_email(email)
    where('lower(email) = ?', email.downcase).first
  end
end
