Rails.application.routes.draw do
  devise_for :users
  root to: 'reservations#index'
  resources :orders, only: [:index, :create, :show]
  resources :reservations, only: [:show, :new, :create, :edit, :update, :destroy]
  resources :users, only: [:edit, :update, :show ]
end
