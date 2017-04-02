require 'rails_helper'

feature 'Export volunteers' do
  include UserSpecHelper

  let(:coach) { create :coach }
  let!(:volunteer_1) { create :volunteer, coach: coach }
  let!(:volunteer_2) { create :volunteer, coach: coach }
  let!(:volunteer_3) { create :volunteer }

  before do
    5.times { create :donation, volunteer: volunteer_1 }
    3.times { create :donation, volunteer: volunteer_2 }
  end

  scenario 'Coach exports donations' do
    sign_in_user coach.user

    expect(page).to have_content('Dashboard')

    visit volunteers_path

    click_link('Download as CSV')

    expect(page.response_headers['Content-Type']).to eq('text/csv')

    csv = CSV.parse(source)
    expect(csv.length).to eq(3)
    expect(csv[0]).to eq(%w(id name email phone city donations_count coach_id coach_name fellow_id fellow_name nfh_id nfh_name sign_in_count last_sign_in_at created_at updated_at))
    expect(csv[1]).to eq([volunteer_2.id.to_s, volunteer_2.user.name, volunteer_2.user.email, volunteer_2.user.phone, volunteer_2.city.name, '3', coach.id.to_s, coach.user.name, coach.fellow.id.to_s, coach.fellow.user.name, coach.national_finance_head.id.to_s, coach.national_finance_head.user.name, volunteer_2.user.sign_in_count.to_s, nil, volunteer_2.created_at.to_s, volunteer_2.updated_at.to_s])
    expect(csv[2]).to eq([volunteer_1.id.to_s, volunteer_1.user.name, volunteer_1.user.email, volunteer_1.user.phone, volunteer_1.city.name, '5', coach.id.to_s, coach.user.name, coach.fellow.id.to_s, coach.fellow.user.name, coach.national_finance_head.id.to_s, coach.national_finance_head.user.name, volunteer_1.user.sign_in_count.to_s, nil, volunteer_1.created_at.to_s, volunteer_1.updated_at.to_s])
  end
end
