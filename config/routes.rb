Rails.application.routes.draw do
  root to: 'public/homes#top'
  get 'about' => 'public/homes#about'

  devise_for :customers
  devise_for :admins

  namespace :admin do
    root 'homes#top', as: :root
    resources :items
    resources :genres
    resources :customers
    resources :orders, only: [:update, :show]
  end


  end
