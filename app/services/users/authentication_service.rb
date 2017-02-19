module Users
  class AuthenticationService
    def initialize(email, password)
      @email = email
      @password = password
    end

    def auth_info
      [jwt, user&.name, user&.roles_array]
    end

    private

    def jwt
      JsonWebTokenService.encode(user_id: user.id) if user
    end

    def user
      @user ||= begin
        user = User.find_by(email: @email)
        user.authenticate(@password) if user.present?
      end
    end
  end
end
