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

  # get '/hello/index'
  # get '/goodbye', to: 'application#goodbye'
  # get '/upsert', to: 'hello#upsert'
  # get '/debug', to: 'hello#debug'
  # get '/insert', to: 'hello#insert'
  # get '/kiq', to: 'hello#kiq'
  # get '/practice', to: 'practice#insert_user'

  # resources :ajax

  # require 'sidekiq/web'
  # mount Sidekiq::Web => '/sidekiq'
end
