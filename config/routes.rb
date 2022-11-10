# frozen_string_literal: true

require 'sidekiq/web' if Rails.env.development?

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?

  resources :closest_satellites, only: :index
  resources :async_closest_satellites, only: :index
  mount ActionCable.server => '/cable'
end
