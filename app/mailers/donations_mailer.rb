class DonationsMailer < ApplicationMailer
  # Send a receipt to the donor.
  def receipt(email, name)
    @name = name
    mail(subject: 'GoDreams Donation Receipt', to: email)
  end
end
