require_relative 'helper'

puts 'Seeding National Finance Heads'

nfh_users = (1..4).map do
  User.create!(
    name: Faker::Name.name ,
    email: Faker::Internet.email,
    phone: "9876543#{100 + rand(100)}",
    password: 'password'
  )
end

nfh_users.each do |user|
  NationalFinanceHead.create!(user: user)
end

