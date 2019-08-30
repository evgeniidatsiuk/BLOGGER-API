# frozen_string_literal: true

class Api::V1::NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_notification, except: format(w, index)
  
  def index
    @notifications = current_user.notifications
    render status: 200, json: {
      success: true,
      notifications: @notifications
    }
  end

  def read
    @notification.update(read: true)
  end

  def unread
    @notification.update(read: false)
  end

  private

  def find_notification
    @notification = Notification.find_by_id(params[:id])
  rescue StandardError => e
    @error = e.message
    render_error(400, nil, @error)
  end
end
