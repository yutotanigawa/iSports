Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # admin側のルーティング
  devise_for :admins, controllers:{
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations'
  }

  namespace :admins do
    root 'homes#top'
    resources :users, only: [:index,:show,:update]
    resources :teams, only: [:index,:show,:update,:destroy]
    get 'applications' => 'teams#applications'
    resources :genres, only: [:index,:create,:edit,:update,:destroy]
  end
  # user側のルーティング
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  root 'homes#top'
  get 'homes/about' => 'homes#about'

  resources :users, only:[:index,:show,:edit,:update] do
    get 'cancel' => 'users#cancel'
    patch 'withdraw' => 'users#withdraw'
    put 'withdraw' => 'users#withdraw'
  end

  resources :teams, only:[:index,:show,:new,:create,:update,:destroy] do
    resource :bookmarks, only:[:create,:destroy]
    get :bookmarks, on: :collection
  end

  resources :messages, only:[:create]
  resources :rooms, only:[:create,:show]


  resource :contacts, only:[:new, :create] do
    post 'confirm' => 'contacts#confirm'
  end

end
