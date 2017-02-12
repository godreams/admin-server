class DonationsMailer < ApplicationMailer
  def test_message(test_email)
    mail(subject: 'Test message', to: test_email)
  end
end
