require_relative 'helper'

after "development:fellows" do
  puts 'Seeding Coaches'

  coach_users = (1..4).map do
    name = Faker::Name.name

    User.create!(
      name: name,
      email: Faker::Internet.email(name),
      phone: "9876543#{100 + rand(100)}",
      password: 'password'
    )
  end

  coach_users[0..1].each do |user|
    Coach.create!(user: user, fellow: Fellow.first)
  end

  coach_users[2..3].each do |user|
    Coach.create!(user: user, fellow: Fellow.second)
  end
end
