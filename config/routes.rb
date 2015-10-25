Rails.application.routes.draw do
  resources :posts, only: [:index, :show]
  resources :authors, only: [:show]
  root to: "posts#index"
end
