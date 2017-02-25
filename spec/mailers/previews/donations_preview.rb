# Preview all emails at http://localhost:3000/rails/mailers/donations
class DonationsPreview < ActionMailer::Preview
  def acknowledgement
    DonationsMailer.acknowledgement('johndoe@example.com', 'John Doe', 1000)
  end

  def receipt
    donation = Donation.joins(:approvals).find_by(approvals: { approver_type: 'NationalFinanceHead' })
    raise 'No approved donation available for rendering preview' if donation.blank?
    DonationsMailer.receipt(donation.id)
  end
end
