# Preview all emails at http://localhost:3000/rails/mailers/donations
class DonationsPreview < ActionMailer::Preview
  def receipt
    DonationsMailer.receipt('johndoe@example.com', 'John Doe')
  end
end
