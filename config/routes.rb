Rails.application.routes.draw do
  devise_for :users
  root to: 'reservations#index'
  resources :reservations do
    resources:orders, only:[:index,:create]
  end
  resources :users, only: [:edit, :update, :show ]
  resources :reservations, only: [:index, :new, :show, :edit, :destroy]
end
