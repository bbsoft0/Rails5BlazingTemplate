require 'sidekiq/web'
Rails.application.routes.draw do

  # writer your routes here

  mount Sidekiq::Web => '/sidekiq'
  #mount ActionCable.server => '/cable'
  root to: 'visitors#index'
end
