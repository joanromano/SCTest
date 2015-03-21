Rails.application.routes.draw do
  get '/artists', to: 'artists#index'
end
