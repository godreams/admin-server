class UsersController < ApplicationController
  def show
    render json: current_user.slice(:id, :name, :email)
  end
end
