Rails.application.routes.draw do

  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection
  end

  get "admin/index"
  get "home/index"

  get 'admin' => 'admin#index'

  get "up" => "rails/health#show", as: :rails_health_check

  get 'products' => 'home#products', as: :products
  get 'products/list/(page/:page)' => 'home#turbo_products', as: :turbo_products
  get 'products/likes' => 'products#likes', as: :likes_product
  post 'products/:id/like' => 'products#like', as: :like_product
  delete 'products/:id/like' => 'products#unlike', as: :unlike_product

  namespace :admin do

    get 'users/list/(page/:page)' => 'users#turbo_list', :as => 'turbo_users'
    get 'roles/list/(page/:page)' => 'roles#turbo_list', :as => 'turbo_roles'
    get 'products/list/(page/:page)' => 'products#turbo_list', :as => 'turbo_products'

    resources :users, concerns: :paginatable   
    resources :roles, concerns: :paginatable
    resources :products, concerns: :paginatable
    
    root to: 'admin#index'
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  devise_scope :user do
    get 'users/sign_out' => 'devise/sessions#destroy'
  end

  root to: "home#index"
end
