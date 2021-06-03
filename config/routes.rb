Rails.application.routes.draw do
  resources :merchants, only: [] do
    resources :dashboard, only: [:index]
    resources :invoices, only: [:index, :show, :update]
    resources :items, only: [:index, :show, :new, :create, :update]
  end

  namespace :admin do
    resources :dashboard, only: [:index]
    resources :merchants, only: [:index, :show]
    resources :invoices, only: [:index, :show, :update]
  end
end
