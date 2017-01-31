module Donations
  class AcknowledgementJob < ApplicationJob
    def perform(donation)
      # Send acknowledgement to donor.
    end
  end
end
