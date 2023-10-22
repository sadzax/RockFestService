Rails.application.routes.draw do
  get '/buy', to: 'buying#new'
  post '/buy', to: 'buying#buy'
end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html