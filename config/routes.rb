Rails.application.routes.draw do
  get "dashboard", to: "pages#dashboard"
  root "pages#index"
end
