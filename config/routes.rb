Rails.application.routes.draw do
  root 'sessions#home'

  # Sessions routes
  get '/auth/login', to: 'sessions#login'
  post '/auth/login', to: 'sessions#create'
  post '/auth/logout', to: 'sessions#destroy'
  get '/auth/logout', to: 'sessions#destroy'
  
  # Users routes
  resources :users, only: [:new, :create, :edit, :update, :show, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
