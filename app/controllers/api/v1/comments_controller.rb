# frozen_string_literal: true

class Api::V1::CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    comment = current_user.comments.build(comment_params)
    if comment.save
      render status: 201, json: {
        success: true,
        comment: comment
      }
    else
      render_error(400, comment)
    end
  end

  def destroy
    if comment.destroy
      render status: 200, json: {
        success: true
      }
    else
      render_error(400, comment)
    end
  end

  def like
    @comment = Comment.find(params[:id])
    if !@comment.likes.find_by(user_id: current_user.id)
      like = @comment.likes.create(user_id: current_user.id)
      render status: 200, json: {
        success: true,
        likes: @comment.likes
      }
    else
      like = @comment.likes.find_by(user_id: current_user.id)
      like.destroy
      render status: 200, json: {
        success: true
      }
    end
end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :text, :object_type, :object_id)
  end

  def comment
    @comment ||= current_user.comments.find_by(id: params[:id])
    @comment ||= Comment.new
  end
end
