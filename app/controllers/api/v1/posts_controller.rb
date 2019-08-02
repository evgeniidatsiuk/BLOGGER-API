# frozen_string_literal: true

class Api::V1::PostsController < ApplicationController
  before_action :find_post, except: %i[index create]
  before_action :authenticate_user!, except: %i[index show]

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      render status: 201, json: {
        success: true,
        post: @post
      }
    else
      render_error(400, @post)
    end
   end

  def index
    @posts = Post.all
    render status: 200, json: {
      success: true,
      posts: @posts
    }
  end

  def update
    if current_user == @post.user && @post.update(post_params)
      render status: 200, json: {
        success: true,
        post: @post
      }
    else
      render_error(400, @post)
    end
 end

  def destroy
    if current_user == @post.user && @post.destroy
      render status: 200, json: {
        success: true
      }
    else
      render_error(400, @post)
    end
  end

  def show
    render status: 200, json: {
     success: true,
     post: @post
   }
  end

  private

  def find_post
    @post = Post.find_by_id(params[:id])
  rescue StandardError => e
    @error = e.message
    render_error(400, nil, @error)
  end

  def post_params
    params.require(:post).permit(:user_id, :title, :body)
  end
end
