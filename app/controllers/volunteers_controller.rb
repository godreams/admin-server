class VolunteersController < ApplicationController
  # GET /volunteers
  def index
    @volunteers = current_user_role.volunteers.includes(:user).order('created_at DESC')
  end

  # POST /volunteers
  def create
    raise Users::AuthorizationFailedException if current_coach.blank?

    form = Volunteers::CreateForm.new(Volunteer.new)

    if form.validate(params)
      form.save!(current_coach)
      @volunteer = form.model
    else
      raise ValidationFailureException.new(form)
    end
  end
end