Rails.application.routes.draw do
  resources :watchlist, only: %i[index create destroy]

  devise_for :users, controllers: {registrations: "registrations"}

  resources :reviews, except: %i[show new create]

  resources :users, only: %i[show] do
    resources :reviews, only: %i[create new]
  end

  resources :bookings, except: %i[new create show]

  # Defines the resourceful routes for the listings controller
  resources :listings do
    resources :bookings, only: %i[new create]
  end

  # Defines the root path route ("/")
  root 'listings#index'
end
