class VolunteersController < ApplicationController
  # GET /volunteers
  def index
    authorize Volunteer
    @volunteers = current_user_role.volunteers.includes(:user).order('created_at DESC')

    respond_to do |format|
      format.html
      format.csv { render csv: @volunteers, filename: "volunteers_#{Time.now.strftime('%Y%m%d_%H%M%S')}" }
    end
  end

  # GET /volunteers/new
  def new
    authorize Volunteer
    @form = Volunteers::CreateForm.new(User.new)
  end

  # POST /volunteers
  def create
    authorize Volunteer

    @form = Volunteers::CreateForm.new(User.new)

    if @form.validate(params[:volunteers_create])
      @form.save(current_user)
      flash[:notice] = 'A new volunteer has been assigned!'
      redirect_to volunteers_path
    else
      render 'new'
    end
  end
end
