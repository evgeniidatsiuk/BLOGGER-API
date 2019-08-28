# frozen_string_literal: true

class Api::V1::NotificationsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @notifications = current_user.notifications
    render status: 200, json: {
      success: true,
      notifications: @notifications
    }
  end
end
