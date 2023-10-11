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

  resources :users, only: [:show, :edit] do
    member do
      get 'edit_icon'
      put 'update_icon'
      get 'edit_name'
      patch 'update_name'
      get 'liked_items'
      get 'followers'
      get 'followings'
    end

    resource :relationships, only: [:create, :destroy]
  end

end