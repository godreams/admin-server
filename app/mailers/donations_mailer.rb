class DonationsMailer < ApplicationMailer
  # Send a acknowledgement to the donor.
  def acknowledgement(email, name, amount)
    @name = name
    @amount = amount
    mail(subject: 'GoDreams Donation Acknowledgement', to: email)
  end
end
