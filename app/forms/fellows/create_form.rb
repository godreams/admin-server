module Fellows
  class CreateForm < Reform::Form
    property :email, validates: { presence: true, email: true }

    validate :fellow_must_be_unique

    def fellow_must_be_unique
      return if user&.fellow.blank?
      errors[:email] << 'is already a Fellow'
    end

    def save(current_user)
      if user.blank?
        @user = User.invite!({ email: email }, current_user)
      end

      user.create_fellow!(national_finance_head: current_user.national_finance_head)
      user.fellow
    end

    private

    def user
      @user ||= User.with_email(email)
    end
  end
end
