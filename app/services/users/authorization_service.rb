module Users
  class AuthorizationService
    def initialize(headers = {})
      @headers = headers
    end

    def user
      @user ||= begin
        User.find(decoded_auth_token[:user_id]) if decoded_auth_token
      end
    end

    private

    def decoded_auth_token
      @decoded_auth_token ||= JsonWebTokenService.decode(http_auth_header)
    end

    def http_auth_header
      if @headers['Authorization'].present?
        @headers['Authorization'].split(' ').last
      end
    end
  end
end
