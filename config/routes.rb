Rails.application.routes.draw do
  devise_for :users
  root "items#index"
  resources :items do
    resource :likes, only: [:create, :destroy]
    collection do
      get 'search'
      get 'incremental'
    end
  end
  resources :users, only: :show
end