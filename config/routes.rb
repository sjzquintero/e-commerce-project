Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Dynamic route for static pages
  get '/pages/:title', to: 'static_pages#show', as: 'static_page'

  # Root route
  root "home#index"

  # Routes for products
  get 'products', to: 'products#index', as: 'products'
  get 'products/category/:id', to: 'products#by_category', as: 'products_by_category'
end
