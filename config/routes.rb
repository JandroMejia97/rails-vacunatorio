Rails.application.routes.draw do
  resources :vaccines
  resources :turns
  resources :vaccination_centers
  resources :applied_vaccines, :path => 'applied_vaccine'
  root 'user_profiles#me'

  # Sessions routes
  get '/auth/login', to: 'sessions#login'
  post '/auth/login', to: 'sessions#create'
  get '/auth/logout', to: 'sessions#destroy'

  # Turns routes
  get '/show_all', to: 'turns#show_all', as: 'show_all'
  get '/pending_turns', to: 'turns#pending_turns'
  get '/new_manual', to: 'turns#new_manual', as: 'new_manual'
  post '/new_manual', to: 'turns#create_manual'
  post '/mark_turns_as_lost', to: 'turns#mark_turns_as_lost'


  # Vaccines routes
  get '/applied_vaccines/new', to: 'applied_vaccines#new', as: 'new_applied_vaccines'
  post '/applied_vaccines/new', to: 'turns#pending_turns'

  # Profiles routes
  get '/users/index', to: 'users#index', as: 'index'
  get '/profile/me', to: 'user_profiles#me', as: 'me'
  get '/profile/me/edit', to: 'user_profiles#edit', as: 'edit_profile'
  patch '/profile/me/edit', to: 'user_profiles#update', as: 'update_profile'
  get '/auth/signin/profile', to: 'user_profiles#new', as: 'new_user_profile'
  post '/auth/signin/profile', to: 'user_profiles#create', as: 'create_user_profile'
  # Accounts routes
  get '/auth/signin/account', to: 'user_accounts#new', as: 'new_user_account'
  post '/auth/signin/account', to: 'user_accounts#create', as: 'create_user_account'

  # Vaccination Center routes
 

  resources :users, only: [:edit, :update, :show, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

