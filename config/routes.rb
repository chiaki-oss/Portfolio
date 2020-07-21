Rails.application.routes.draw do
  devise_for :admins, controllers: {
  	sessions: 'admin/sessions',
    passwords: 'admin/passwords',
    registrations: 'admin/registrations'
  }

  namespace :admin do
  	get 'top' => 'home#top'
  	resources :users, only: [:index, :show, :edit, :update]
  	resources :posts
  	resources :genres, only: [:index, :create, :edit, :update]
  	resources :prefectures, only: [:index]
  	resources :areas, only: [:index, :create, :edit, :update]
  end

  devise_for :users, controllers: {
  	sessions: 'public/sessions',
    passwords: 'public/passwords',
    registrations: 'public/registrations'
  }

  scope module: :public do
  	root 'home#top'
  	get 'about' => 'home#about'
  	get 'confirm' => 'users#confirm'
  	put 'confirm' => 'users#withdraw'
  	get 'mypage' => 'users#show'
  	get 'mypage/edit' => 'users#edit'
  	patch 'mypage' => 'users#update'
  	resources :posts
  	resources :genres, only: [:index]
  	resources :prefectures, only: [:index]
  	resources :areas, only: [:index]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
