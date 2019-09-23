Rails.application.routes.draw do
  devise_for :users
  resources :pages
  resources :users
  resources :type_of_repairs
  resources :vehicles do 
    resources :bookings
    resources :auto_histories
  end
  resources :day_of_weeks do
    resources :day_of_business_hours
  end

  get 'home/index'
  root to: "home#index"
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
