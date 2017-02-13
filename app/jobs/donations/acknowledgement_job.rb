module Donations
  class AcknowledgementJob < ApplicationJob
    def perform(donation)
      # Send an SMS.
      sms_service = SmsService.new(donation.phone, :donation_acknowledgement, name: donation.name, amount: donation.amount)
      sms_service.execute

      # Send an email.
      DonationsMailer.acknowledgement(donation.email, donation.name, donation.amount).deliver_now
    end
  end
end
