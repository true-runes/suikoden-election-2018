# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#home'

  resources :pages do
    collection do
      get :how_to_vote
      get :thanks
      get :duplicate_check # 不要
      get :summary
      get :ranking
      get :now_counting
    end
  end

  resources :votes, only: %i[index create] # 将来的に必要
  resources :check_vote, only: %i[index create] # :create は不要っぽい Ajaxにしたかった

  get '/practice', to: 'practice#index'

  # require 'sidekiq/web'
  # mount Sidekiq::Web => '/sidekiq'
end
