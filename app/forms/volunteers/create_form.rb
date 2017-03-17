module Volunteers
  class CreateForm < Reform::Form
    property :email, validates: { presence: true, email: true }

    validate :volunteer_must_be_unique

    def volunteer_must_be_unique
      return if user&.volunteer.blank?
      errors[:email] << 'is already a Volunteer'
    end

    def save(current_user)
      if user.blank?
        @user = User.invite!({ email: email }, current_user)
      end

      user.create_volunteer!(coach: current_user.coach)
      user.volunteer
    end

    private

    def user
      @user ||= User.with_email(email)
    end
  end
end
