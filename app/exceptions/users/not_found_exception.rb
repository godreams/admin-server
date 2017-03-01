module Users
  class NotFoundException
    def initialize
      @code = :not_found
      @message = 'No such user exists'
      @description = 'Could not find a user with the supplied email address.'
      @status = 404
    end
  end
end
