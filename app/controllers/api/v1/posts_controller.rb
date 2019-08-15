# frozen_string_literal: true

class Api::V1::PostsController < ApplicationController
  before_action :find_post, except: %i[index create]
  before_action :authenticate_user!, except: %i[index show likes]

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
    @posts = Post.page(params[:page]).per(10).order('created_at DESC')
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
        post: {
          id: @post.id,
          user_id: @post.user_id,
          title: @post.title,
          body: @post.body,
          likes_count: @post.likes.count,
          likes: @post.likes,
          comments: Comment.where(object_id: @post.id, object_type: 'Post').page(params[:page]).per(10).order('created_at DESC'),
          comments_count: @post.comments.count
        }
      }
    end

  def like
    if !@post.likes.find_by(user_id: current_user.id)
      like = @post.likes.create(user_id: current_user.id)
      render status: 200, json: {
        success: true,
        like: @post.likes
      }
    else
      @like = @post.likes.find_by(user_id: current_user.id)
      @like.destroy
      render status: 200, json: {
        success: true
      }
    end
  end

  def liked_posts
    @posts = Post.where(user_id: current_user.id).joins(:likes) # Like.where(user_id: current_user.id, object_type: "Post")
    render status: 200, json: {
      success: true,
      posts: @posts
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
