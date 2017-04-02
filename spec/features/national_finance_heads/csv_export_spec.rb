require 'rails_helper'

feature 'Export national finance heads' do
  include UserSpecHelper

  let!(:national_finance_head_1) { create :national_finance_head }
  let!(:national_finance_head_2) { create :national_finance_head }
  let!(:fellow_1) { create :fellow, national_finance_head: national_finance_head_1 }
  let!(:fellow_2) { create :fellow, national_finance_head: national_finance_head_1 }
  let!(:fellow_3) { create :fellow, national_finance_head: national_finance_head_2 }
  let!(:coach_1) { create :coach, fellow: fellow_1 }
  let!(:coach_2) { create :coach, fellow: fellow_2 }
  let!(:coach_3) { create :coach, fellow: fellow_3 }

  before do
    3.times { create :volunteer, coach: coach_1 }
    4.times { create :volunteer, coach: coach_2 }
    5.times { create :volunteer, coach: coach_3 }
  end

  scenario 'Coach exports donations' do
    sign_in_user national_finance_head_1.user

    expect(page).to have_content('Dashboard')

    national_finance_head_1.reload

    visit national_finance_heads_path

    click_link('Download as CSV')

    expect(page.response_headers['Content-Type']).to eq('text/csv')

    csv = CSV.parse(source)
    expect(csv.length).to eq(3)
    expect(csv[0]).to eq(%w(id name email phone fellows_count coaches_count volunteers_count sign_in_count last_sign_in_at created_at updated_at))
    expect(csv[1]).to eq([national_finance_head_1.id.to_s, national_finance_head_1.user.name, national_finance_head_1.user.email, national_finance_head_1.user.phone, '2', '2', '7', '1', national_finance_head_1.user.last_sign_in_at.to_s, national_finance_head_1.created_at.to_s, national_finance_head_1.updated_at.to_s])
    expect(csv[2]).to eq([national_finance_head_2.id.to_s, national_finance_head_2.user.name, national_finance_head_2.user.email, national_finance_head_2.user.phone, '1', '1', '5', national_finance_head_2.user.sign_in_count.to_s, nil, national_finance_head_2.created_at.to_s, national_finance_head_2.updated_at.to_s])
  end
end
