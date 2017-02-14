class FellowsController < ApplicationController
  # GET /fellows
  def index
    @fellows = current_user_role.fellows.includes(:user).order('created_at DESC')
  end

  # POST /fellows
  def create
    raise Users::AuthorizationFailedException if current_national_finance_head.blank?

    form = Fellows::CreateForm.new(Donation.new)

    if form.validate(params)
      form.save!(current_national_finance_head)
      render json: { success: true, fellow: form.model }
    else
      raise ValidationFailureException.new(form)
    end
  end
end