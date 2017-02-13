# Preview all emails at http://localhost:3000/rails/mailers/donations
class DonationsPreview < ActionMailer::Preview
  def acknowledgement
    DonationsMailer.acknowledgement('johndoe@example.com', 'John Doe', 1000)
  end
end
