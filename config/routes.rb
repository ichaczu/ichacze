Rails.application.routes.draw do
  get 'documents/download'

  root to: "dashboards#index"
  resources :loans do
    member do
      get :pay_installment
      get :get_document
    end
  end
  resources :borrowers
  resources :guarantors
  resources :monits
  resources :visits
  devise_for :users
end
