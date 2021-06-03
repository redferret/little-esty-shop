Rails.application.routes.draw do
  namespace :merchants do
    resources :dashboard, only: [:index]
    resources :invoices, only: [:index, :show, :update]
    resources :items, only: [:index, :show, :new, :create, :update]
  end
  
  namespace :admin do
    resources :dashboard, only: [:index]
    resources :merchants, only: [:index, :show]
  end
    resources :invoices, only: [:index, :show, :update]
end
