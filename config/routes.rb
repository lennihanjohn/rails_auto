Rails.application.routes.draw do
  devise_for :users
  resources :pages
  resources :users
  resources :type_of_repairs
  resources :vehicles
  resources :auto_histories

  resources :bookings
  resources :business_hours 
  resources :day_of_business_hours
  get 'home/index'
  root to: "home#index"
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
