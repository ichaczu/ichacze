Rails.application.routes.draw do
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
  devise_for :users
end
