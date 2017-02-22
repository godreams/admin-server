class UsersMailer < ApplicationMailer
  # Send password on user creation
  def send_password(user, password)
    @user = user
    @password = password
    mail(subject: 'Welcome to GoDreams DonorApp', to: @user.email)
  end
end
