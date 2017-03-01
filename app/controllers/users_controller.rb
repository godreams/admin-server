class UsersController < ApplicationController
  def show
    @user = current_user
  end

  # GET /users/find?email=
  def find
    @user = User.with_email(params[:email])
    raise Users::NotFoundException if @user.blank?
  end
end
