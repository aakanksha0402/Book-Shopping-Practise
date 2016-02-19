BookShopping::Application.routes.draw do
  get '/administrators/welcome' => 'administrators#welcome'
  resources :administrators

  get "/login" => "sessions#new"
  post "sessions/create"
  delete "sessions/destroy"
  get "store/index"
  post "store/index"
  post "product/show"
  post "products/new"

  scope '(:locale)' do
    resources :line_items
    resources :carts
    resources :products
    resources :orders
    root 'store#index', as: 'store'
  end
end
