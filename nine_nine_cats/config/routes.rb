Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :cats

  resources :cat_rental_requests, only: [:create, :new] do
    patch "approve", on: :member
    patch "deny", on: :member
  end

  # resources :cat_rental_requests, only: [:new, :create]
  # patch 'cat_rental_requests/:id/approve',
  #   to: 'cat_rental_requests#approve',
  #   as: 'approve_cat_rental_request'
  # patch 'cat_rental_requests/:id/deny',
  #   to: 'cat_rental_requests#deny',
  #   as: 'deny_cat_rental_request'
end
