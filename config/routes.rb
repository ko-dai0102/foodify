Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  root "items#index"

  resources :items do
    resource :likes, only: [:create, :destroy]
    resource :comments, only: :create
    collection do
      get 'tag_show'
      get 'search'
      get 'incremental'
      get 'timeline'
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

    resource :relationships, only: [:create, :destroy] do
      member do
        post 'list_create'
        delete 'list_destroy'
      end
    end

  end

end