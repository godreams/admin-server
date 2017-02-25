module Donations
  class ApprovalIncompleteException
    def initialize
      @code = :approval_incomplete
      @message = 'This donation is not fully approved'
      @description = 'A receipt for this donation can only be generated once it is approved by a National Finance Head.'
    end
  end
end

