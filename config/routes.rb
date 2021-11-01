Rails.application.routes.draw do
  root 'sessions#home'

  # Sessions routes
  get '/auth/login', to: 'sessions#login'
  post '/auth/login', to: 'sessions#create'
  post '/auth/logout', to: 'sessions#destroy'
  get '/auth/logout', to: 'sessions#destroy'
  # Profiles routes
  get '/auth/signin/profile', to: 'user_profiles#new', as: 'new_user_profile'
  post '/auth/signin/profile', to: 'user_profiles#create', as: 'create_user_profile'
  # Accounts routes
  get '/auth/signin/account', to: 'user_accounts#new', as: 'new_user_account'
  post '/auth/signin/account', to: 'user_accounts#create', as: 'create_user_account'

  resources :users, only: [:edit, :update, :show, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
