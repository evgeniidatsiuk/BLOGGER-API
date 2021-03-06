# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  include DeviseTokenAuth::Concerns::User

  has_many :posts,               dependent: :destroy
  has_many :likes, as: :object,  dependent: :destroy
  has_many :comments,            dependent: :destroy
  has_many :notifications,       dependent: :destroy

end
