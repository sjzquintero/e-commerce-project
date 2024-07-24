# frozen_string_literal: true

Rails.application.routes.draw do
  get 'carts/show'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get 'up' => 'rails/health#show', as: :rails_health_check

  get '/pages/:title', to: 'static_pages#show', as: 'static_page'

  root 'home#index'

  resource :cart, only: [:show] do
    post 'add_product/:product_id', action: :add_product, as: 'add_product'
    patch 'update_quantity/:id', action: :update_quantity, as: 'update_quantity'
    delete 'remove_product/:id', action: :remove_product, as: 'remove_product'

    get 'checkout', on: :collection
    post 'process_checkout', to: 'carts#process_checkout'
  end

  get 'products/on_sale', to: 'products#on_sale', as: 'on_sale_products'
  get 'products/new_products', to: 'products#new_products', as: 'new_products'
  get 'products', to: 'products#index', as: 'products'
  get 'products/category/:id', to: 'products#by_category', as: 'products_by_category'
  get 'products/search', to: 'products#search', as: 'search_products'
  get 'products/:id', to: 'products#show', as: 'product'
end
