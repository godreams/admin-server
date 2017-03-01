module Coaches
  class CreateForm < Reform::Form
    property :name, validates: { presence: true }
    property :email, validates: { presence: true, email: true }
    property :phone, validates: { presence: true, mobile_number: true }

    validates_uniqueness_of :email

    def save(fellow)
      user = Users::CreateService.create(email: email, phone: phone, name: name)
      user.create_coach!(fellow: fellow)
      user.coach
    end
  end
end
