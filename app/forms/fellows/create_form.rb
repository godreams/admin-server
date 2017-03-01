module Fellows
  class CreateForm < Reform::Form
    property :name, validates: { presence: true }
    property :email, validates: { presence: true, email: true }
    property :phone, validates: { presence: true, mobile_number: true }

    validates_uniqueness_of :email

    def save(national_finance_head)
      user = Users::CreateService.create(email: email, phone: phone, name: name)
      user.create_fellow!(national_finance_head: national_finance_head)
      user.fellow
    end
  end
end
