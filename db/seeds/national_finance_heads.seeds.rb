require_relative 'helper'

puts 'Seeding National Finance Head (production)'

initial_user = User.create!(
  name: 'Initial User',
  email: 'user@godreams.org',
  phone: '9876543210',
  password: 'password'
)

NationalFinanceHead.create!(user: initial_user)
