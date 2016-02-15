BookShopping::Application.routes.draw do
  get '/administrators/welcome' => 'administrators#welcome'
  resources :administrators
  # post 'administrators/welcome'
  resources :line_items
  resources :carts
  resources :products
  resources :orders

  get "sessions/new"
  post "sessions/create"
  delete "sessions/destroy"
  get "admins/index"
  post "store/index"
  post "product/show"
  post "products/new"
  get "store/index"
  root 'store#index', as: 'store'

end
