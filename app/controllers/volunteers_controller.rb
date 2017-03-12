class VolunteersController < ApplicationController
  # GET /volunteers
  def index
    authorize Volunteer
    @volunteers = current_user_role.volunteers.includes(:user).order('created_at DESC')
  end

  # POST /volunteers
  def create
    raise Users::AuthorizationFailedException if current_coach.blank?

    form = Volunteers::CreateForm.new(User.new)

    if form.validate(params)
      @volunteer = form.save(current_coach)
    else
      raise ValidationFailureException.new(form)
    end
  end
end
