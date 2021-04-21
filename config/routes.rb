Rails.application.routes.draw do
  root 'books#index'
  resources :genres
  resources :books
  resources :orders
  resources :book_orders
  get '/cart', to: 'cart#index', as: 'cart_index'
  post '/cart/:id', to: 'cart#create', as: 'cart_create'
  delete '/cart/:id', to: 'cart#destroy', as: 'cart_delete'
  patch '/cart/:id', to: 'cart#patch', as: 'cart_reduce'

  devise_for :users, controllers: {
    registrations: 'users/registration'
  }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
