Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  get '/', to: 'bookings#new'
  get '/bookings', to: 'bookings#new'
  resources :bookings, only: [:show, :create, :destroy, :new, :update]
end
