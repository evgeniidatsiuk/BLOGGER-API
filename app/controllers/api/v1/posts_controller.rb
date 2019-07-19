# frozen_string_literal: true

  class Api::V1::PostsController < ApplicationController

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

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
