class ApplicationController < ActionController::Base
  include Pundit
  after_action :verify_authorized, except: :index, unless: :devise_controller?
  # TODO: Enable this after updating current index routes.
  # after_action :verify_policy_scoped, only: :index

  protect_from_forgery with: :reset_session
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :current_user_role

  rescue_from ApplicationException, with: :show_exception

  protected

  def show_exception(exception)
    render json: exception.response, status: exception.status
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:name, :name, :phone])
  end

  private

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
    current_user&.dominant_role
  end
end
