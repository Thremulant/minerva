Rails.application.routes.draw do
  resources :genres
  resources :books
  resources :orders
  resources :book_orders
  resources :cart
  root 'books#index'

  devise_for :users, controllers: {
    registrations: 'users/registration'
  }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
