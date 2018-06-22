Rails.application.routes.draw do
  root 'pages#home'

  resources :pages do
    collection do
      get :how_to_vote
      get :check_vote
    end
  end

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
