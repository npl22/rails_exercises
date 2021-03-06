Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get '/users', to: 'users#index'
  # post '/users', to: 'users#create'
  # get '/users/:id', to: 'users#show', :as => 'user'
  # patch '/users/:id', to: 'users#update'
  # delete '/users/:id', to: 'users#destroy'
  # get '/users/:id/edit', to: 'users#edit', :as => 'edit_user'
  # get '/users/new', to: 'users#new', :as => 'new_user'

  resources :users, only: [:index, :show, :create, :update, :destroy] do
    resources :artworks, only: :index
    resources :comments, only: :index
  end
  resources :artworks, only: [:show, :create, :update, :destroy] do
    resources :comments, only: :index
  end
  resources :artwork_shares, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]

  resources :likes, only: [:create, :destroy]
end
