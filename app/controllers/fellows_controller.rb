class FellowsController < ApplicationController
  # GET /fellows
  def index
    @fellows = current_user_role.fellows.includes(:user).order('created_at DESC')
  end

  # POST /fellows
  def create
    raise Users::AuthorizationFailedException if current_national_finance_head.blank?

    form = Fellows::CreateForm.new(User.new)

    if form.validate(params)
      @fellow = form.save(current_national_finance_head)
    else
      raise ValidationFailureException.new(form)
    end
  end
end
