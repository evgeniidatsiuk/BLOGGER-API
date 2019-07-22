# frozen_string_literal: true

class Api::V1::PostsController < ApplicationController\
  before_action :find_post, except: %i[index create]

  def create
    @post = Post.create(post_params)

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
    if @post.update(post_params)
      render status: 200, json: {
        success: true,
        post: @post
      }
    else
      render_error(400, @post)
    end
 end

  def destroy
    @post.destroy
    render status: 200, json: {
      success: true
    }
  end

  private

  def find_post
    @post = Pist.find_by_id(params[:id])
  rescue StandardError => e
    @error = e.message
    render_error(400, nil, @error)
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
