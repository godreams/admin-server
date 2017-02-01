module Donations
  class DeleteNotAllowedException < ApplicationException
    def initialize
      @code = :delete_not_allowed
      @message = 'You are not allowed to delete donations'
      @description = 'Only a National Finance Head or a Fellow are allowed to delete donations. You are not registered as either.'
      @status = 401
    end
  end
end
