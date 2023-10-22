Rails.application.routes.draw do
  get 'events/:date/:category', to: 'events#tickets_count'
  patch 'events/:date/:category', to: 'events#increase_tickets'
end
