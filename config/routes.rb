Rails.application.routes.draw do
  resources :posts, only: [:index, :show]
  resources :authors, only: [:show, :new, :create]
  resources :likes, only: [:update]
  resources :stats, only: [:index]
  resource :search, only: [:show]

  resource :sessions, only: [:create, :destroy]

  get '/about', to: "static#about", as: :about

  root to: "posts#index"
end
