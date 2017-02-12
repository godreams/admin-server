class DonationsMailer < ApplicationMailer
  def test_message
    mail(subject: 'Test message', to: 'sheldon@bigbangtheory.com')
  end
end
