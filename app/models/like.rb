class Like < ApplicationRecord
  belongs_to :object, polymorphic: true
  has_many :notifications, as: :object, dependent: :destroy
end
