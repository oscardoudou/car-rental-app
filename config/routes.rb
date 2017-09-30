Rails.application.routes.draw do
  get 'sadminl/index'

  get 'adminl/index'

  get 'sessions/new'

  get 'users/new'

  get 'users/show'

  resources :orders
  resources :line_items
  resources :reservations
  resources :users
  get 'store/index'
  post 'reservations/new'
  post 'orders/new'
  get '/signup', to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :cars
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'store#index', as: 'store'
end
