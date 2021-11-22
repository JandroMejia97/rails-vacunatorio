Rails.application.routes.draw do
  resources :vaccines
  resources :turns
  resources :applied_vaccines, :path => 'applied_vaccine'
  root 'user_profiles#me'

  # Sessions routes
  get '/auth/login', to: 'sessions#login'
  post '/auth/login', to: 'sessions#create'
  get '/auth/logout', to: 'sessions#destroy'

  # Turns routes
  get '/show_all', to: 'turns#show_all'
  get '/pending_turns', to: 'turns#pending_turns'
  post '/mark_turns_as_lost', to: 'turns#mark_turns_as_lost'


  # Vaccines routes
  get '/applied_vaccines/new', to: 'applied_vaccines#new', as: 'new_applied_vaccines'
  post '/applied_vaccines/new', to: 'turns#pending_turns'

  
  # Profiles routes
  get '/profile/modify', to: 'user_profiles#modify', as: 'modify'
  post '/profile/modify', to: 'user_profiles#all_users'
  patch '/profile/modify', to: 'user_profiles#update2', as:'update2'
  get '/profile/all_users', to: 'user_profiles#all_users', as: 'all_users'
  get '/profile/me', to: 'user_profiles#me', as: 'me'
  get '/profile/me/edit', to: 'user_profiles#edit', as: 'edit_profile'
  patch '/profile/me/edit', to: 'user_profiles#update', as: 'update_profile'
  get '/auth/signin/profile', to: 'user_profiles#new', as: 'new_user_profile'
  post '/auth/signin/profile', to: 'user_profiles#create', as: 'create_user_profile'
  # Accounts routes
  get '/auth/signin/account', to: 'user_accounts#new', as: 'new_user_account'
  post '/auth/signin/account', to: 'user_accounts#create', as: 'create_user_account'

  resources :users, only: [:edit, :update, :show, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
