# frozen_string_literal: true

class Api::V1::UsersController < ApplicationController
  def index
    @users = User.all
    render status: 200,
           json: {
             success: true,
             users: @users
           }
  end

  def show
    @user = User.find_by_id(params[:id])
    render status: 200,
           json: {
             success: true,
             user: @user,
             posts: Post.where(user_id: @user.id).page(params[:page]).per(10)
           }
  end
end
