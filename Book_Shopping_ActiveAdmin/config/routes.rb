BookShopping::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :line_items
  resources :carts
  resources :products
  resources :orders

  post "store/index"
  post "product/show"
  post "products/new"
  get "store/index"
  root 'store#index', as: 'store'

end
