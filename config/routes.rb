Rails.application.routes.draw do

  resources :merchants, only: [:index, :show] do
    member do
      get :dashboard
    end
    resources :invoices, only: [:index, :show, :update]
    resources :items, only: [:index, :show, :new, :create, :update]
  end

end
