# frozen_string_literal: true

class Api::V1::LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post

  def create
    if !post_liked?
      like = @post.likes.create(user_id: current_user.id)
      if like.save
        render status: 201, json: {
          success: true,
          like: like
        }
      else
        render_error(400, like)
      end
    else
      render status: 400, json: {
        success: false,
        like: like
      }
    end
  end

  def destroy
    if post_liked?
      like = @post.likes.find(params[:id])
      like.destroy
      render status: 201, json: {
        success: true,
        like: like
      }
    else
      render status: 400, json: {
        success: false,
        like: like
      }
  end
  end

  private

  def post_liked?
    Like.where(user_id: current_user.id, object_id: @post.id).exists?
  end

  def like_params
    params.require(:like).permit(:object_id, :object_type, :user_id)
  end

  def find_post
    @post = Post.find_by_id(params[:post_id])
  end
end
