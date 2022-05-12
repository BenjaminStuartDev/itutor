Rails.application.routes.draw do
  devise_for :users
  get 'reviews/index'
  get 'reviews/show'
  get 'reviews/new'
  get 'reviews/edit'
  get 'reviews/update'
  get 'reviews/destroy'
  get 'users/index'
  get 'users/show'
  get 'users/new'
  get 'users/edit'
  get 'users/update'
  get 'users/destroy'

  resources :bookings, except: :show
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
