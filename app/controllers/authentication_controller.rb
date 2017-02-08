class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  # GET /authenticate
  def authenticate
    token, name, role = Users::AuthenticationService.new(params[:email], params[:password]).auth_info

    raise Users::SignInFailedException if token.blank?

    render json: { auth_token: token, name: name, role: role }
  end
end
