module Users
  class AuthenticationService
    def initialize(email, password)
      @email = email
      @password = password
    end

    def auth_info
      [jwt, user&.name, user_role]
    end

    private

    def jwt
      JsonWebTokenService.encode(user_id: user.id) if user
    end

    def user_role
      (user.national_finance_head || user.fellow || user.coach || user.volunteer).class.name
    end

    def user
      @user ||= begin
        user = User.find_by(email: @email)
        user.authenticate(@password) if user.present?
      end
    end
  end
end
