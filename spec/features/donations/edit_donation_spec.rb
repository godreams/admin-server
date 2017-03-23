require 'rails_helper'

feature 'Edit donation' do
  include UserSpecHelper

  let(:volunteer) { create :volunteer }
  let(:donation) { create :donation, volunteer: volunteer, pan: 'ABCD', address: 'Somewhere, Somewhen' }
  let(:amount) { donation.amount }
  let(:name) { donation.name }

  scenario 'Coach edits donation' do
    sign_in_user volunteer.coach.user

    expect(page).to have_content('Dashboard')

    visit donation_path(donation)

    click_link('Edit Donation')

    fill_in 'Amount', with: amount * 2
    fill_in 'PAN', with: 'EFGH'
    click_button 'Update'

    expect(page).to have_content('Donation has been successfully updated!')
    expect(page).to have_content("#{amount * 2} from #{name}")

    visit donation_path(donation)

    expect(page).to have_content('Last edited by')
    expect(page).to have_content(JSON.pretty_generate('amount': [amount, amount * 2], pan: %w(ABCD EFGH)))
  end
end
