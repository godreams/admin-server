module Volunteers
  class CreateForm < Reform::Form
    property :name, validates: { presence: true }
    property :email, validates: { presence: true, email: true }
    property :phone, validates: { presence: true, mobile_number: true }

    validates_uniqueness_of :email

    def save(coach)
      user = Users::CreateService.create(email: email, phone: phone, name: name)
      user.create_volunteer!(coach: coach)
      user.volunteer
    end
  end
end
