Rails.application.routes.draw do
  devise_for :users

  resources :reviews, except: %i[show new create]

  resources :users do
    get 'reviews', to: 'reviews#tutor_reviews'
    post 'reviews', to: 'reviews#create'
    get 'reviews/new', to: 'reviews#new'
    resources :bookings, except: :show
  end
  get 'users/index'
  get 'users/show'
  get 'users/new'
  get 'users/edit'
  get 'users/update'
  get 'users/destroy'

  # get 'bookings/index'
  # get 'bookings/show'
  # get 'bookings/new'
  # get 'bookings/edit'
  # get 'bookings/update'
  # get 'bookings/destroy'

  # Defines the resourceful routes for the listings controller
  resources :listings

  # Defines the root path route ("/")
  root 'listings#index'
end
