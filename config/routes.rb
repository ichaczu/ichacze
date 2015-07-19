Rails.application.routes.draw do
  root to: "dashboards#index"
  resources :loans
  resources :borrowers
  resources :guarantors
  devise_for :users
end
