Rails.application.routes.draw do
  namespace :public do
    get 'contacts/new'
    get 'contacts/create'
  end

  devise_for :admins, controllers: {
  	sessions: 'admin/sessions',
    passwords: 'admin/passwords',
    registrations: 'admin/registrations'
  }

  devise_scope :admin do
    post '/admins/guest_sign_in', to: 'admin/sessions#guest'
  end

  namespace :admin do
  	get 'top' => 'homes#top'
  	resources :users, only: [:index, :show, :edit, :update]
  	resources :posts
  	resources :genres, only: [:index, :create, :edit, :update]
  	resources :prefectures, only: [:edit, :update]
  	resources :areas, only: [:index, :create, :edit, :update]
    resources :contacts, only: [:index, :edit, :update, :destroy]
  end

  devise_for :users, controllers: {
  	sessions: 'public/sessions',
    passwords: 'public/passwords',
    registrations: 'public/registrations'
  }

  devise_scope :user do
    post '/users/guest_sign_in', to: 'public/sessions#new_guest'
  end

  scope module: :public do
  	root 'homes#top'
  	get 'about' => 'homes#about'
  	get 'confirm' => 'users#confirm'
  	put 'confirm' => 'users#withdraw'
    resources :users, only: [:show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get 'follows' => 'relationships#follower', as: 'follows'
      get 'follows/timeline' => 'relationships#timeline'
      get 'followers' => 'relationships#followed', as: 'followers'
    end
  	resources :posts do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
      collection do
        get :history
      end
    end
    get 'favorites' => 'favorites#index'
    resources :contacts, only: [:new, :create, :index, :show]
    post 'contacts/confirm' => 'contacts#confirm'
    resources :notifications, only: [:index]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
