Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "products#index"

  get 'products', to: 'products#index'

  resource :cart, only: [:show, :destroy]

  resources :cart_items
end
