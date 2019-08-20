Rails.application.routes.draw do
  root 'users#show'
  resources :comments
  
  resources :users, except: [:index] do
    resources :posts
  end

  resources :images, only: [:destroy]

  resources :likes
  resources :sessions, only: [:create]
  get '/auth/:provider/callback', to: 'sessions#create'
  delete 'comment_image', to: 'comments#destroy_image', as: 'comment_image'
  get 'search', to: 'users#index', as: 'search'
  get 'signup', to: 'users#new', as: 'signup'
  post 'signup', to: 'users#create'
  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy', as: 'logout'
end
