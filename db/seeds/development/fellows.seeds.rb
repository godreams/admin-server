require_relative 'helper'

after "development:national_finance_heads" do
  puts 'Seeding Fellows'

  fellow_users = (1..4).map do
    User.create!(
      name: Faker::Name.name ,
      email: Faker::Internet.email,
      phone: "9876543#{100 + rand(100)}",
      password: 'password'
    )
  end

  fellow_users[0..1].each do |user|
    Fellow.create!(user: user, national_finance_head: NationalFinanceHead.first)
  end

  fellow_users[2..3].each do |user|
    Fellow.create!(user: user, national_finance_head: NationalFinanceHead.second)
  end
end