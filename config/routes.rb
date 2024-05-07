Rails.application.routes.draw do
  devise_for :users
  root to: 'reservations#index'
  resources :reservations do
    resources :orders, only: [:index, :create,:show]
  end
  resources :users, only: [:edit, :update, :show]
end
