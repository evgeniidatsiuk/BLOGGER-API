# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user

  has_many :likes,    as: :object,  dependent: :destroy
  has_many :comments, as: :object,  dependent: :destroy
  has_many :notifications, as: :object, dependent: :destroy

  validates :title, :body, presence: true

  after_create :create_notification

  def create_notification
    Notification.create(object_type: 'Post', object_id: id, text: 'Post created!', user_id: user.id)
  end
end
