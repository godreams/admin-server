class ApplicationController < ActionController::API
  before_action :authenticate_request

  attr_reader :current_user

  def hello
    render json: { hello: :world }
  end

  private

  def authenticate_request
    @current_user = Users::AuthorizationService.new(request.headers).user
    render json: { errors: [{
      code: :not_authorized,
      message: 'Could not validate authorization',
      description: 'Please authenticate and acquire JWT before attempting to access restricted routes. JWT should be passed in the Authorization header.'
    }] }, status: 401 unless @current_user
  end

  def current_volunteer
    current_user&.volunteer
  end

  def current_coach
    current_user&.coach
  end

  def current_fellow
    current_user&.fellow
  end

  def current_national_finance_head
    current_user&.national_finance_head
  end

  def current_user_role
    current_national_finance_head || current_fellow || current_coach || current_volunteer
  end
end
