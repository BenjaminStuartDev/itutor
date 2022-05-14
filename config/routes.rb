Rails.application.routes.draw do
  devise_for :users

  resources :reviews, except: %i[show new create]

  resources :users, only: [:show] do
    get 'reviews', to: 'reviews#tutor_reviews'
    post 'reviews', to: 'reviews#create'
    get 'reviews/new', to: 'reviews#new'
  end

  resources :bookings, except: %i[new create show]

  # Defines the resourceful routes for the listings controller
  resources :listings do
    resources :bookings, only: %i[new create]
  end

  # Defines the root path route ("/")
  root 'listings#index'
end
