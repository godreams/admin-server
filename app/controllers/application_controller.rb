class ApplicationController < ActionController::Base
  protect_from_forgery with: :reset_session

  # before_action :authenticate_request

  helper_method :current_user, :current_user_role

  rescue_from ApplicationException, with: :show_exception

  protected

  def show_exception(exception)
    render json: exception.response, status: exception.status
  end

  def current_user
    @current_user ||= Users::AuthorizationService.new(request.headers).user
  end

  private

  def authenticate_request
    raise Users::AuthenticationFailedException if current_user.blank?
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
