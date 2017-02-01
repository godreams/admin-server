module Donations
  class ApproveNotAllowedException < ApplicationException
    def initialize
      @code = :approve_not_allowed
      @message = 'You are not allowed to approve donations'
      @description = 'Only a National Finance Head or a Fellow are allowed to approve donations. You are not registered as either.'
      @status = 401
    end
  end
end
