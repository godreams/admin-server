module UserSpecHelper
  def sign_in_user(user, password: 'password')
    visit new_user_session_path
    fill_in 'Email address', with: user.email
    fill_in 'Password', with: password
    click_button 'Sign in'
  end
end
