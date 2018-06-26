Rails.application.routes.draw do
  root 'pages#home'

  resources :pages do
    collection do
      get :how_to_vote
      get :thanks
      get :duplicate_check
    end
  end

  resources :votes, only: [:index, :create]
  resources :check_vote, only: [:index, :create]

  # get '/practice', to: 'practice#insert_user'

  # require 'sidekiq/web'
  # mount Sidekiq::Web => '/sidekiq'
end
