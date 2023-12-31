class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name bio photo])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name bio photo])
  end

  def after_sign_in_path_for(_resource)
    users_path
  end

  def after_sign_up_path_for(_resource)
    users_path
  end

  # # Catch all CanCan errors and alert the user of the exception
  # rescue_from CanCan::AccessDenied do |exception|
  #   redirect_to root_url, alert: exception.message
  # end
end
