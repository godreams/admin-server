module Volunteers
  class CreateForm < Reform::Form
    property :name, validates: { presence: true }
    property :email, validates: { presence: true, email: true }
    property :phone, validates: { presence: true, mobile_number: true }

    def save!(coach)
      # TODO: Remove stupid default password. Probably generate a random password or send them a one time login link to set a password.
      user = User.create!(email: email, phone: phone, name: name, password: 'password')
      Volunteer.create!(user: user, coach: coach)
    end
  end
end
