Rails.application.routes.draw do
  get '/hello/index'
  get '/goodbye', to: 'application#goodbye'
end
