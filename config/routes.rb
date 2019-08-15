Rails.application.routes.draw do
  root 'users#show'
  resources :comments
  resources :users, except: [:index] do
    resources :posts
  end

  resources :likes
  resources :sessions, only: [:create]

  get 'search', to: 'users#index', as: 'search'
  get 'signup', to: 'users#new', as: 'signup'
  post 'signup', to: 'users#create'
  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
