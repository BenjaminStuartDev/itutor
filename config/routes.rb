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
  get 'bookings/index'
  get 'bookings/show'
  get 'bookings/new'
  get 'bookings/edit'
  get 'bookings/update'
  get 'bookings/destroy'
  get 'listings/index', to: 'listing#index'
  get 'listings/show'
  get 'listings/new'
  get 'listings/edit'
  get 'listings/update'
  get 'listings/destroy'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'listings#index', to: 'listing#index'
end
