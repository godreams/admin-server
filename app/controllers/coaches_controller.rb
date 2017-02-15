class CoachesController < ApplicationController
  # GET /coaches
  def index
    @coaches = current_user_role.coaches.includes(:user).order('created_at DESC')
  end

  # POST /coaches
  def create
    raise Users::AuthorizationFailedException if current_fellow.blank?

    form = Coaches::CreateForm.new(Coach.new)

    if form.validate(params)
      form.save!(current_fellow)
      @coach = form.model
    else
      raise ValidationFailureException.new(form)
    end
  end
end