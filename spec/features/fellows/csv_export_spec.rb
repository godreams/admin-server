require 'rails_helper'

feature 'Export fellows' do
  include UserSpecHelper

  let(:national_finance_head) { create :national_finance_head }
  let!(:fellow_1) { create :fellow, national_finance_head: national_finance_head }
  let!(:fellow_2) { create :fellow, national_finance_head: national_finance_head }
  let!(:fellow_3) { create :fellow }
  let!(:coach_1) { create :coach, fellow: fellow_1 }
  let!(:coach_2) { create :coach, fellow: fellow_1 }
  let!(:coach_3) { create :coach, fellow: fellow_2 }

  before do
    2.times { create :volunteer, coach: coach_1 }
    2.times { create :volunteer, coach: coach_2 }
    2.times { create :volunteer, coach: coach_3 }
  end

  scenario 'Coach exports donations' do
    sign_in_user national_finance_head.user

    expect(page).to have_content('Dashboard')

    visit fellows_path

    click_link('Download as CSV')

    expect(page.response_headers['Content-Type']).to eq('text/csv')

    csv = CSV.parse(source)
    expect(csv.length).to eq(3)
    expect(csv[0]).to eq(%w(id name email phone city coaches_count volunteers_count nfh_id nfh_name sign_in_count last_sign_in_at created_at updated_at))
    expect(csv[1]).to eq([fellow_2.id.to_s, fellow_2.user.name, fellow_2.user.email, fellow_2.user.phone, fellow_2.city.name, '1', '2', fellow_2.national_finance_head.id.to_s, fellow_2.national_finance_head.user.name, fellow_2.user.sign_in_count.to_s, nil, fellow_2.created_at.to_s, fellow_2.updated_at.to_s])
    expect(csv[2]).to eq([fellow_1.id.to_s, fellow_1.user.name, fellow_1.user.email, fellow_1.user.phone, fellow_1.city.name, '2', '4', fellow_1.national_finance_head.id.to_s, fellow_1.national_finance_head.user.name, fellow_1.user.sign_in_count.to_s, nil, fellow_1.created_at.to_s, fellow_1.updated_at.to_s])
  end
end
