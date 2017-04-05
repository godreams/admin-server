class CitiesController < ApplicationController
  # GET /cities
  def index
    authorize :city
    @cities = City.all
  end

  # GET /cities/new
  def new
    authorize :city
    @form = Cities::CreateForm.new(City.new)
  end

  # POST /cities
  def create
    authorize :city
    @form = Cities::CreateForm.new(City.new)

    if @form.validate(params[:cities_create])
      @form.save
      flash[:notice] = 'New city created!'
      redirect_to cities_path
    else
      render 'new'
    end
  end
end