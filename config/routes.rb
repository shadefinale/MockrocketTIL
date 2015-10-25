Rails.application.routes.draw do
  resources :posts, only: [:index, :show]
  resources :authors, only: [:show]
  resources :likes, only: [:update]
  root to: "posts#index"
end
