module Coaches
  class CreateForm < Reform::Form
    property :email, validates: { presence: true, email: true }

    validate :coach_must_be_unique

    def coach_must_be_unique
      return if user&.coach.blank?
      errors[:email] << 'is already a Coach'
    end

    def save(current_user)
      if user.blank?
        @user = User.invite!({ email: email }, current_user)
      end

      user.create_coach!(fellow: current_user.fellow)
      user.coach
    end

    private

    def user
      @user ||= User.with_email(email)
    end
  end
end
