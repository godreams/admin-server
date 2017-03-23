FactoryGirl.define do
  factory(:donation) do
    volunteer
    name { Faker::Lorem.name }
    email { Faker::Internet.email(name) }
    phone { 9_876_543_210 + rand(10_000) }
    amount { rand(100) * 100 }
  end
end
