class DonationsMailer < ApplicationMailer
  # Send a acknowledgement to the donor.
  def acknowledgement(email, name, amount)
    @name = name
    @amount = amount
    mail(subject: 'GoDreams Donation Acknowledgement', to: email)
  end

  def receipt(donation_id)
    @donation = Donation.find(donation_id)

    attachments['godreams_receipt.pdf'] = {
      mime_type: 'application/pdf',
      content: Donations::ReceiptPdf.new(@donation).build.render
    }

    mail(subject: 'GoDreams Donation Receipt', to: @donation.email, bcc: 'receipts@godreams.org')
  end
end
