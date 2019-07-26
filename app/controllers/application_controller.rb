# frozen_string_literal: true

class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ::UnifiedJsonRender
end
