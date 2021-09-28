Rails.application.routes.draw do
  root to: 'public/homes#top'
  devise_for :customers
  devise_for :admins

  namespace :admin do
    resources :items
    resources :genres
  end


  end
