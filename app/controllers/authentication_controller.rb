class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  # GET /authenticate
  def authenticate
    token = Users::TokenService.new(params[:email], params[:password]).jwt

    raise Users::SignInFailedException if token.blank?

    render json: { auth_token: token }
  end
end
