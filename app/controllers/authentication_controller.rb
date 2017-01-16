class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  # GET /authenticate
  def authenticate
    token = Users::TokenService.new(params[:email], params[:password]).jwt

    if token.present?
      render json: { auth_token: token }
    else
      render json: { errors: [{
        code: :authentication_failure,
        message: 'Failed to authenticate user',
        description: 'The credentials you supplied could not be matched to a known user. Please try again.'
      }] }, status: :unauthorized
    end
  end
end
