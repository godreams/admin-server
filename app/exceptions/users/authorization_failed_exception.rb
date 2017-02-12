module Users
  class AuthorizationFailedException < ApplicationException
    def initialize
      @code = :authorization_failed
      @message = 'Could not validate authorization'
      @description = 'Signed in user does not have the required permissions for this action'
      @status = 401
    end
  end
end
