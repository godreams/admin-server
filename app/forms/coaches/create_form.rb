module Coaches
  class CreateForm < Reform::Form
    property :name, virtual: true, validates: { presence: true }
    property :email, virtual: true, validates: { presence: true, email: true }
    property :phone, virtual: true, validates: { presence: true, mobile_number: true }

    def save!(fellow)
      # TODO: Remove stupid default password. Probably generate a random password or send them a one time login link to set a password.
      user = User.create!(email: email, phone: phone, name: name, password: 'password')
      model.user = user
      model.fellow = fellow
      model.save!
    end
  end
end
