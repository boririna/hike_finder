Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :hikes do
    resources :likes, only: [:create, :update]
    resources :reviews, only: [:create]
  end
  resources :likes, only: [:index,:destroy]
  resources :reviews, only: [:index,  :update, :edit, :destroy]
end
