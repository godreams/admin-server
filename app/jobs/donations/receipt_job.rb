module Donations
  class ReceiptJob < ApplicationJob
    def perform(donation)
      # Send the receipt via email.
      DonationsMailer.receipt(donation.id).deliver_now

      # Send an SMS as notification.
      sms_service = SmsService.new(donation.phone, :donation_receipt, name: donation.name, email: donation.email)
      sms_service.execute
    end
  end
end
