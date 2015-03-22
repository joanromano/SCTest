Rails.application.routes.draw do
  get '/artists', to: 'artists#index'
  get '/users', to: 'backdoor#create'
end
