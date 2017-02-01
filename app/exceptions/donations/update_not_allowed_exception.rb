module Donations
  class UpdateNotAllowedException < ApplicationException
    def initialize
      @code = :update_not_allowed
      @message = 'You are not allowed to update donations'
      @description = 'Only a National Finance Head, Fellow, or Coach are allowed to update donations - you are not registered as any of those.'
      @status = 401
    end
  end
end
