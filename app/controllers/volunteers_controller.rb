class VolunteersController < ApplicationController
  def index
    @volunteers = current_user_role.volunteers.includes(:user).order('created_at DESC')
  end
end