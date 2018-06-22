require 'sidekiq/web'

Rails.application.routes.draw do
  root 'pages#home'

  get '/hello/index'
  get '/goodbye', to: 'application#goodbye'
  get '/upsert', to: 'hello#upsert'
  get '/debug', to: 'hello#debug'
  get '/insert', to: 'hello#insert'
  get '/kiq', to: 'hello#kiq'
  get '/practice', to: 'practice#insert_user'

  resources :ajax

  mount Sidekiq::Web => '/sidekiq'
end
