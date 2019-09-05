class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :object, polymorphic: true

  has_many :likes,    as: :object, dependent: :destroy
  has_many :comments, as: :object, dependent: :destroy
  has_many :notifications, as: :object, dependent: :destroy

  after_create :create_notification


  validates :text, presence: true

  def create_notification
    Notification.create(object_type: 'Comment', object_id: id, text: text, user_id: user.id)
  end
end
