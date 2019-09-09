# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :user
  belongs_to :object, polymorphic: true
  has_many :notifications, as: :object, dependent: :destroy

  after_create :create_notification

  def create_notification
    Notification.create(object_type: 'Like', object_id: id, text: 'Like created in post!', user_id: user.id)
  end
end
