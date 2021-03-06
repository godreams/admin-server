class CoachesController < ApplicationController
  # GET /coaches
  def index
    authorize Coach
    @coaches = current_user_role.coaches.includes(:user).order('created_at DESC')

    respond_to do |format|
      format.html
      format.csv { render csv: @coaches, filename: "coaches_#{Time.now.strftime('%Y%m%d_%H%M%S')}" }
    end
  end

  # GET /coaches/new
  def new
    authorize Coach
    @form = Coaches::CreateForm.new(User.new)
  end

  # POST /coaches
  def create
    authorize Coach

    @form = Coaches::CreateForm.new(User.new)

    if @form.validate(params[:coaches_create])
      @form.save(current_user)
      flash[:notice] = 'A new coach has been assigned!'
      redirect_to coaches_path
    else
      render 'new'
    end
  end
end
