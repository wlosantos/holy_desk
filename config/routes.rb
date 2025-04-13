Rails.application.routes.draw do
  devise_for :users

  get "dashboard", to: "pages#dashboard"
  root "pages#index"

  resources :users, only: %i[ index ]
  resources :tenants
end
