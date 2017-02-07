module Users
  class SignInFailedException < ApplicationException
    def initialize
      @code = :sign_in_failed
      @message = 'Could not sign in user with supplied credentials'
      @description = 'Please authenticate and acquire JWT before attempting to access restricted routes. JWT should be passed in the Authorization header.'
    end
  end
end
