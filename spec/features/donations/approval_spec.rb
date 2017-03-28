require 'rails_helper'

feature 'Approve donation' do
  include UserSpecHelper

  let(:donation) { create :donation }
  let(:national_finance_head) { donation.volunteer.national_finance_head }

  scenario 'Volunteer creates donation' do
    sign_in_user national_finance_head.user

    expect(page).to have_content('Dashboard')

    visit donation_path(donation)

    click_link('Approve')

    expect(page).to have_content('Your approval of the donation has been recorded.')

    # The receipt should be sent to the donor.
    open_email(donation.email)

    expect(current_email.subject).to eq('GoDreams Donation Receipt')
    expect(current_email).to have_content('As promised, please find attached the e-receipt of your contribution to Guardians of Dreams Foundation.')
    expect(current_email.attachments.first.filename).to eq('godreams_receipt.pdf')

    # The receipt should also be delivered to receipts@godreams.org.
    open_email('receipts@godreams.org')

    expect(current_email.subject).to eq('GoDreams Donation Receipt')
    expect(current_email.attachments.first.filename).to eq('godreams_receipt.pdf')
  end
end
