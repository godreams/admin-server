require 'rails_helper'

feature 'Export donations' do
  include UserSpecHelper

  let(:coach) { create :coach }
  let(:volunteer_1) { create :volunteer, coach: coach }
  let(:volunteer_2) { create :volunteer, coach: coach }
  let!(:donation_1) { create :donation, volunteer: volunteer_1 }
  let!(:donation_2) { create :donation, volunteer: volunteer_2 }
  let!(:donation_3) { create :donation }

  scenario 'Coach exports donations' do
    sign_in_user coach.user

    expect(page).to have_content('Dashboard')

    visit donations_path

    click_link('Download as CSV')

    expect(page.response_headers['Content-Type']).to eq('text/csv')

    csv = CSV.parse(source)
    expect(csv.length).to eq(3)
    expect(csv[0]).to eq(%w(id name email phone amount pan address tax_claim volunteer_id volunteer_name created_at updated_at last_edited_by))
    expect(csv[2]).to eq([donation_1.id.to_s, donation_1.name, donation_1.email, donation_1.phone, donation_1.amount.to_s, nil, nil, 'false', volunteer_1.id.to_s, volunteer_1.name, donation_1.created_at.to_s, donation_1.updated_at.to_s, nil])
    expect(csv[1]).to eq([donation_2.id.to_s, donation_2.name, donation_2.email, donation_2.phone, donation_2.amount.to_s, nil, nil, 'false', volunteer_2.id.to_s, volunteer_2.name, donation_2.created_at.to_s, donation_2.updated_at.to_s, nil])
  end
end
