Rails.application.routes.draw do
  resources :logs
  get 'enter', to: 'tickets#enter'
  get 'exit', to: 'tickets#exit'
  get 'block', to: 'tickets#block'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
