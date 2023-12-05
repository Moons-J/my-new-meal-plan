Rails.application.routes.draw do
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root to: "pages#dashboard"
  # get 'dashboard', to: 'pages#dashboard', as: 'dashboard'
  resources :meals, only: %i[index new create edit update destroy]
  resources :daily_plans, only: %i[index new create show]
  resources :ingredients, only: %i[index new create edit update destroy]
  resources :account, only: %i[edit update]
  resources :groceries, only: %i[index]
end
