Rails.application.routes.draw do
  get "admin/index"
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    get "home/index"
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

    get 'admin' => 'admin#index'

    # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
    # Can be used by load balancers and uptime monitors to verify that the app is live.
    get "up" => "rails/health#show", as: :rails_health_check

    # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
    # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
    # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

    concern :paginatable do
      get '(page/:page)', action: :index, on: :collection
    end

    namespace :admin do
      resources :users, concerns: :paginatable   
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

    # Defines the root path route ("/")
    root to: "home#index"
  end
end
