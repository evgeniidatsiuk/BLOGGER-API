# frozen_string_literal: true

class Api::V1::PostsController < ApplicationController
  respond_to :json

  def create
    post = Post.new(post_params)
    if post.save
      render json: '{"success": "200/201 OK!"}'
    else render json: '{"error", "Invalid values"}'
    end
  end

  def index
    posts = Post.all
    render json: posts
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
