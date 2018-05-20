require 'sidekiq/web'
# mount Sidekiq::Web => '/sidekiq'

Rails.application.routes.draw do
  root 'hello#index'

  get '/hello/index'
  get '/goodbye', to: 'application#goodbye'
end
