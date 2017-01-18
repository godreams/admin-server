require_relative 'helper'

after "development:coaches" do
  puts 'Seeding Volunteers'

  volunteer_users = (1..10).map do
    User.create!(
      name: Faker::Name.name ,
      email: Faker::Internet.email,
      phone: "9876543#{100 + rand(100)}",
      password: 'password'
    )
  end

  volunteer_users[0..1].each do |user|
    Volunteer.create!(user: user, coach: Coach.first)
  end

  volunteer_users[2..3].each do |user|
    Volunteer.create!(user: user, coach: Coach.second)
  end

  volunteer_users[4..6].each do |user|
    Volunteer.create!(user: user, coach: Coach.third)
  end

  volunteer_users[7..9].each do |user|
    Volunteer.create!(user: user, coach: Coach.fourth)
  end
end