require_relative 'helper'

after "development:volunteers" do
  puts 'Seeding Donations'

  10.times do
    Donation.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      phone: "9876543#{100 + rand(100)}",
      amount: (1 + rand(9)) * 500,
      volunteer: Volunteer.all.sample
    )
  end
end