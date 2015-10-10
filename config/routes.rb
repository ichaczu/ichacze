Rails.application.routes.draw do
  root to: "dashboards#index"
  resources :loans do
    member do
      get :pay_installment
    end
  end
  resources :borrowers
  resources :guarantors
  devise_for :users
end
