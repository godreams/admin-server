class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :registerable
  devise :invitable, :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  has_one :volunteer, dependent: :destroy
  has_one :coach, dependent: :destroy
  has_one :fellow, dependent: :destroy
  has_one :national_finance_head, dependent: :destroy
  has_many :invitations, class_name: 'User', as: :invited_by

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

  # volunteer? coach? fellow? national_finance_head?
  %w(volunteer coach fellow national_finance_head).each do |role|
    define_method("#{role}?") do
      public_send(role).present?
    end
  end

  def dominant_role
    national_finance_head || fellow || coach || volunteer
  end
end
