# frozen_string_literal: true

Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/v1/auth'
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[index show]
      resources :posts, except: %i[edit]
      resources :comments, only: %i[create destroy show update]
      post 'posts/:id/likes',              to: 'posts#like'
      post 'comments/:id/likes',           to: 'comments#like'
      get 'comments/:id/likes',            to: 'comments#likes'
      get 'liked',                         to: 'posts#liked_posts'
    end
  end
end
