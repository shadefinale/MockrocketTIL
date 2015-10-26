Rails.application.routes.draw do
  resources :posts, only: [:index, :show]
  resources :authors, only: [:show]
  resources :likes, only: [:update]
  resources :stats, only: [:index]
  root to: "posts#index"
end
