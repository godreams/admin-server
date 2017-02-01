module Donations
  class AlreadyApprovedException < ApplicationException
    def initialize
      @code = :already_approved
      @message = 'This donation has already been approved'
      @description = 'This donation was approved at an earlier date and time. Duplicate approvals are blocked.'
    end
  end
end
