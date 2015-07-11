Rails.application.routes.draw do
  root to: "dashboards#index"
  devise_for :users
end
