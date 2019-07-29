# frozen_string_literal: true

Rails.application.routes.draw do
  apipie
  mount_devise_token_auth_for 'User', at: 'api/v1/auth'
    namespace :api do
      namespace :v1 do
    resources :posts, only: %i[index create update destroy show]
    resources :users, only: %i[index show]
  end
  end
end
