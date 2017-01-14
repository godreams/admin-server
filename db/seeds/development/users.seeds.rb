User.create!(
  name: 'Test User',
  email: 'testuser@example.com',
  confirmed_at: Time.now,
  password: 'password',
  password_confirmation: 'password'
)
