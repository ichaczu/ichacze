Rails.application.routes.draw do
  get 'borrowers/edit'

  root to: "dashboards#index"
  resources :loans
  resources :borrowers
  resources :guarantors
  devise_for :users
end
