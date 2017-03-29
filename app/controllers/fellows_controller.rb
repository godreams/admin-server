class FellowsController < ApplicationController
  # GET /fellows
  def index
    authorize Fellow
    @fellows = current_user_role.fellows.includes(:user).order('created_at DESC')

    respond_to do |format|
      format.html
      format.csv { render csv: @fellows, filename: "fellows_#{Time.now.strftime('%Y%m%d_%H%M%S')}" }
    end
  end

  # GET /fellows/new
  def new
    authorize Fellow
    @form = Fellows::CreateForm.new(User.new)
  end

  # POST /fellows
  def create
    authorize Fellow
    @form = Fellows::CreateForm.new(User.new)

    if @form.validate(params[:fellows_create])
      @form.save(current_user)
      flash[:notice] = 'A new fellow has been assigned!'
      redirect_to fellows_path
    else
      render 'new'
    end
  end
end
