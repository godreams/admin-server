class UsersController < ApplicationController
  def show
    @user_role = current_user_role
  end
end
