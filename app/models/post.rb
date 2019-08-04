# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user

  has_many :likes, as: :object,  dependent: :destroy
  has_many :comments,            dependent: :destroy

  validates :title, :body, presence: true
end
