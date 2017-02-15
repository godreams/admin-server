module Fellows
  class CreateForm < Reform::Form
    property :name, virtual: true, validates: { presence: true }
    property :email, virtual: true, validates: { presence: true, email: true }
    property :phone, virtual: true, validates: { presence: true, mobile_number: true }

    def save!(national_finance_head)
      user = Users::CreateService.create(email: email, phone: phone, name: name)
      model.user = user
      model.national_finance_head = national_finance_head
      model.save!
    end
  end
end
