module Users
  class TokenService
    def initialize(email, password)
      @email = email
      @password = password
    end

    def jwt
      JsonWebTokenService.encode(user_id: user.id) if user
    end

    private

    def user
      @user ||= begin
        user = User.find_by(email: @email)
        user.authenticate(@password) if user.present?
      end
    end
  end
end
