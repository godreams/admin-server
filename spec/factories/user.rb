FactoryGirl.define do
  factory(:user) do
    name { Faker::Name.name }
    email { Faker::Internet.email(name) }
    sequence(:phone) { |n| (9876543210 + n).to_s }
    password 'password'
    password_confirmation 'password'
  end
end
