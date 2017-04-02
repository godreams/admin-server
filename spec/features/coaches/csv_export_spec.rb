require 'rails_helper'

feature 'Export coaches' do
  include UserSpecHelper

  let(:fellow) { create :fellow }
  let!(:coach_1) { create :coach, fellow: fellow }
  let!(:coach_2) { create :coach, fellow: fellow }
  let!(:coach_3) { create :coach }

  before do
    4.times { create :volunteer, coach: coach_1 }
    2.times { create :volunteer, coach: coach_2 }
  end

  scenario 'Coach exports donations' do
    sign_in_user fellow.user

    expect(page).to have_content('Dashboard')

    visit coaches_path

    click_link('Download as CSV')

    expect(page.response_headers['Content-Type']).to eq('text/csv')

    csv = CSV.parse(source)
    expect(csv.length).to eq(3)
    expect(csv[0]).to eq(%w(id name email phone city volunteers_count fellow_id fellow_name nfh_id nfh_name sign_in_count last_sign_in_at created_at updated_at))
    expect(csv[1]).to eq([coach_2.id.to_s, coach_2.user.name, coach_2.user.email, coach_2.user.phone, coach_2.city.name, '2', fellow.id.to_s, fellow.user.name, fellow.national_finance_head.id.to_s, fellow.national_finance_head.user.name, coach_2.user.sign_in_count.to_s, nil, coach_2.created_at.to_s, coach_2.updated_at.to_s])
    expect(csv[2]).to eq([coach_1.id.to_s, coach_1.user.name, coach_1.user.email, coach_1.user.phone, coach_1.city.name, '4', fellow.id.to_s, fellow.user.name, fellow.national_finance_head.id.to_s, fellow.national_finance_head.user.name, coach_1.user.sign_in_count.to_s, nil, coach_1.created_at.to_s, coach_1.updated_at.to_s])
  end
end
