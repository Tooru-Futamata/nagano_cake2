Rails.application.routes.draw do
  root to: 'public/homes#top'
  get 'about' => 'public/homes#about'

  devise_for :customers
  devise_for :admins

  namespace :admin do
    root 'homes#top', as: :root
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:update, :show]
  end

  scope module: :public do
    resources :items, only: [:index, :show]
    resource :customers, only: [:show, :edit, :update,] do
    collection do
    get 'unsubscribe'
    patch 'withdraw'
    end
    end
    resources :cart_items, only: [:index, :update, :destroy, :create] do
    collection do
    delete 'all_destroy'
    end
    end
    resources :orders, only: [:new, :create, :index, :show] do
    collection do
    post 'confirm'
    get 'complete'
    end
    end
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    end

  end
