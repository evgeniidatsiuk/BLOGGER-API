# frozen_string_literal: true

class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ::UnifiedJsonRender

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name image nickname email password password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name image nickname email password password_confirmation current_password])
  end

end
