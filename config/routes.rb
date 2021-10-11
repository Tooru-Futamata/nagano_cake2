Rails.application.routes.draw do
  root to: 'public/homes#top'
  get 'about' => 'public/homes#about'

  namespace :admin do
    root 'homes#top', as: :root
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:update, :show]
    resources :order_details, only: [:update]
  end

  scope module: 'public' do
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    resources :items, only: [:index, :show]
    resource :customers, only: [:update] do
     get 'mypage' => 'customers#show'
     get 'mypage/edit' => 'customers#edit'
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
    get 'orders/complete' => "orders#complete"
    post '/orders/confirm' => 'orders#confirm'

    resources :orders, only: [:new, :create, :index, :show]

    end

    devise_for :customers
    devise_for :admins

end