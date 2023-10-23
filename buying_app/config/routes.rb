Rails.application.routes.draw do
  get '/', to: 'buying#new'
  post '/buy', to: 'buying#buy'
  get '/check_ticket', to: 'buying#check_ticket'
  resources :tickets
end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html