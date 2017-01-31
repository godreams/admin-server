module Donations
  class ApproverRequiredException < BaseException
    def initialize
      @code = :approver_required
      @message = 'You are not allowed to approve donations'
      @description = 'Only a National Finance Head or a Fellow are allowed to approve donations. You are not registered as either.'
    end
  end
end
