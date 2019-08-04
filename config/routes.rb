# frozen_string_literal: true

Rails.application.routes.draw do
  apipie
  mount_devise_token_auth_for 'User', at: 'api/v1/auth'
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[index show]
      resources :posts, except: %i[edit]
      post 'posts/:id/likes', to: 'posts#like'
    end
  end
end
