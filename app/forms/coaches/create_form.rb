module Coaches
  class CreateForm < Reform::Form
    property :name, validates: { presence: true }
    property :email, validates: { presence: true, email: true }
    property :phone, validates: { presence: true, mobile_number: true }

    validate :coach_must_be_unique

    def coach_must_be_unique
      user = User.with_email(email)
      return if user&.coach.blank?
      errors[:email] << 'is already a Coach'
    end

    def save(fellow)
      user = Users::CreateService.find_or_create(email: email, phone: phone, name: name)
      user.create_coach!(fellow: fellow)
      user.coach
    end
  end
end
