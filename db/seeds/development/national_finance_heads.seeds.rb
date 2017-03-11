require_relative 'helper'

puts 'Seeding National Finance Heads'

nfh_users = (1..4).map do
  name = Faker::Name.name

  User.create!(
    name: name,
    email: Faker::Internet.email(name),
    phone: "9876543#{100 + rand(100)}",
    password: 'password'
  )
end

nfh_users.each do |user|
  NationalFinanceHead.create!(user: user)
end

# Make the first National Finance Head play all roles.
nfh = NationalFinanceHead.first
user = nfh.user
fellow = user.create_fellow!(national_finance_head: nfh)
coach = user.create_coach!(fellow: fellow)
user.create_volunteer!(coach: coach)
