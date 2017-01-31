module Donations
  class VolunteerRequiredException < ApplicationException
    def initialize
      @code = :volunteer_required
      @message = 'You are not a volunteer'
      @description = 'Only a volunteer is allowed to perform this action.'
      @status = 401
    end
  end
end
