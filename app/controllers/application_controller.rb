class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  def after_sign_in_path_for(resource)
    if resource.sign_in_count == 1
      root_path
    else
      root_path
    end
  end
  protected


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:role_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name,:last_name,:avatar,:nationality])
  end

end
