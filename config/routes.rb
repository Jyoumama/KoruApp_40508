Rails.application.routes.draw do
  devise_for :users
  get "users/show"
  root to: 'reservations#index'
  resources :reservations do
    resources :orders, only: [:index, :create]
  end
  resources :users, only: [:edit, :update, :show]
end
