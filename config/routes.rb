Rails.application.routes.draw do
  devise_for :users
  get "users/show"
  root to: 'reservations#index'
  resources :reservations do
    resources :orders, only:[:index, :create]

    collection do
      post :charge
    end
  end
  
  resources :users, only: [:edit, :update, :show]
end
