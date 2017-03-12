class CoachesController < ApplicationController
  # GET /coaches
  def index
    authorize Coach
    @coaches = current_user_role.coaches.includes(:user).order('created_at DESC')
  end

  # POST /coaches
  def create
    raise Users::AuthorizationFailedException if current_fellow.blank?

    form = Coaches::CreateForm.new(User.new)

    if form.validate(params)
      @coach = form.save(current_fellow)
    else
      raise ValidationFailureException.new(form)
    end
  end
end
