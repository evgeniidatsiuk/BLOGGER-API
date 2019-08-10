class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :object, polymorphic: true

  has_many :likes,    as: :object, dependent: :destroy
  has_many :comments, as: :object, dependent: :destroy

  validates :text, presence: true
end
