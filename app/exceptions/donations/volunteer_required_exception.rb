module Donations
  class VolunteerRequiredException < BaseException
    def initialize
      @code = :volunteer_required
      @message = 'You are not a volunteer'
      @description = 'Only a volunteer is allowed to perform this action.'
    end
  end
end
