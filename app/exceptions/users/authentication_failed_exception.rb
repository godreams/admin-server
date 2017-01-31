module Users
  class AuthenticationFailedException < BaseException
    def initialize
      @code = :authentication_failed
      @message = 'Could not validate authorization'
      @description = 'Please authenticate and acquire JWT before attempting to access restricted routes. JWT should be passed in the Authorization header.'
      @status = 401
    end
  end
end
