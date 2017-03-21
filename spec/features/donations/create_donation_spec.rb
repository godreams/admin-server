require 'rails_helper'

feature 'Create donation' do
  include UserSpecHelper

  let!(:volunteer) { create :volunteer }

  let(:name) { Faker::Lorem.name }
  let(:email) { Faker::Internet.email(name) }
  let(:phone) { (9_876_543_210 + rand(10_000)).to_s }
  let(:amount) { rand(100) * 100 }
  let(:pan) { "ABCDE#{1000 + rand(8000)}X" }
  let(:address) { Faker::Address.full_address }

  scenario 'User signs in' do
    sign_in_user volunteer.user

    expect(page).to have_content('Dashboard')

    visit donations_path

    click_link('Create New Donation')

    fill_in 'Name', with: name
    fill_in 'Email', with: email
    fill_in 'Phone', with: phone
    fill_in 'Amount', with: amount
    check 'Tax claim?'
    fill_in 'Pan', with: pan
    fill_in 'Address', with: address
    click_button 'Create'

    expect(page).to have_content('Donation has been successfully recorded!')

    expect(page).to have_content("#{amount} from #{name}")

    within('.list-group-item:first') do
      click_link 'View Details'
    end

    expect(page).to have_content(name)
    expect(page).to have_content(email)
    expect(page).to have_content(phone)
    expect(page).to have_content(amount)
    expect(page).to have_content(volunteer.user.name)
    expect(page).to have_content('Pending Coach Approval')
  end
end
