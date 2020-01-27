Rails.application.routes.draw do
  root 'static_pages#index'
  get 'users/new'
  get 'users/create'
  get  'signup',    to: 'users#new'
  post 'signup',    to: 'users#create'
  get  'login',     to: 'sessions#new'
  post 'login',     to: 'sessions#create'
  get  'logout',    to: 'sessions#destroy'
  get  'new_event', to: 'events#new'
  post 'new_event', to: 'events#create'
  post 'events/:id/attend', as: 'attend', to: 'events#attend'
  resources :events
  resources :users
  get '*path', to: 'static_pages#index'
end
