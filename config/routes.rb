Rails.application.routes.draw do
  get '/auth/login', to: 'sessions#login'
  post '/auth/login', to: 'sessions#create'
  post '/auth/logout', to: 'sessions#destroy'
  get '/auth/logout', to: 'sessions#destroy'
  
  resources :users, only: [:new, :create, :index, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
