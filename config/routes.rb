Rails.application.routes.draw do
  get 'sessions/create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      resources :people, only: [:index, :create]
      resources :users
      resources :organizations
      resources :transactions
      resources :accounts
      resources :categories
      resources :bank_lists, only: [:index]
      post 'login', to: 'authentication#login'
      #post 'user_login', to: 'user_authentication#login'
    end
  end
end


