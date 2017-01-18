class ApplicationController < ActionController::API
  # before_action :authenticate_request

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
end
