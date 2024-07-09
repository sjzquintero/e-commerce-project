Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get "up" => "rails/health#show", as: :rails_health_check

  get '/pages/:title', to: 'static_pages#show', as: 'static_page'

  root "home#index"

  get 'products/on_sale', to: 'products#on_sale', as: 'on_sale_products'
  get 'products/new_products', to: 'products#new_products', as: 'new_products'
  get 'products', to: 'products#index', as: 'products'
  get 'products/category/:id', to: 'products#by_category', as: 'products_by_category'
  get 'products/search', to: 'products#search', as: 'search_products'
  get 'products/:id', to: 'products#show', as: 'product'
end
