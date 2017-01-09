Rails.application.routes.draw do
  resources :rooms
  resources :users

  resource :confirmation, only: [:show]
  resource :user_sessions, only: [:create, :new, :destroy]

  resources :rooms do
    resources :reviews, only: [:create, :update], module: :rooms
  end

  root "home#index"
end
