module Volunteers
  class CreateForm < Reform::Form
    property :name, validates: { presence: true }
    property :email, validates: { presence: true, email: true }
    property :phone, validates: { presence: true, mobile_number: true }

    validate :volunteer_must_be_unique

    def volunteer_must_be_unique
      user = User.with_email(email)
      return if user&.volunteer.blank?
      errors[:email] << 'is already a Volunteer'
    end

    def save(coach)
      user = Users::CreateService.find_or_create(email: email, phone: phone, name: name)
      user.create_volunteer!(coach: coach)
      user.volunteer
    end
  end
end
