Rails.application.routes.draw do
  get 'search', to:'search#index'
  resources :tags

    resources :comments do
    get 'search', on: :collection
  end

  devise_for :users
  
  resources :comments
  #get 'home/index'
  get 'home/about'
 # root'home#index'
  root'comments#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
 
end
