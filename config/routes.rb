Rails.application.routes.draw do

  resources :merchants, only: :index do
    member do
      get :dashboard
    end
    resources :items, only: [:index, :show, :create, :update]
    resources :invoices, only: [:index, :show]
  end
end
