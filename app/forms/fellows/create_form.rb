module Fellows
  class CreateForm < Reform::Form
    property :name, validates: { presence: true }
    property :email, validates: { presence: true, email: true }
    property :phone, validates: { presence: true, mobile_number: true }

    validate :fellow_must_be_unique

    def fellow_must_be_unique
      user = User.with_email(email)
      return if user&.fellow.blank?
      errors[:email] << 'is already a Fellow'
    end

    def save(national_finance_head)
      user = Users::CreateService.find_or_create(email: email, phone: phone, name: name)
      user.create_fellow!(national_finance_head: national_finance_head)
      user.fellow
    end
  end
end
