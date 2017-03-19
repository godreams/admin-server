require 'rails_helper'

feature 'User sign in' do
  let!(:volunteer) { create :volunteer }

  scenario 'User signs in' do
    visit root_path

    expect(page).to have_content('Please sign in')

    fill_in 'Email address', with: volunteer.user.email
    fill_in 'Password', with: 'password'
    click_button 'Sign in'

    expect(page).to have_content('Dashboard')
  end
end
