Rails.application.routes.draw do
scope module: :merchants do
  resources :merchants, only: [] do
    resources :dashboard, only: [:index]
    resources :invoices, only: [:index, :show, :update]
    resources :items
  end
end

namespace :admin do
  resources :dashboard, only: [:index]
  resources :merchants
  resources :invoices, only: [:index, :show, :update]
end
end
