Rails.application.routes.draw do
  get 'visits/create'

  get 'monits/index'

  root to: "dashboards#index"
  resources :loans do
    member do
      get :pay_installment
    end
  end
  resources :borrowers
  resources :guarantors
  resources :monits
  resources :visits
  devise_for :users
end
