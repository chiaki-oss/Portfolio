Rails.application.routes.draw do
  devise_for :admins, controllers: {
  	sessions: 'admin/sessions',
    passwords: 'admin/passwords',
    registrations: 'admin/registrations'
  }

  namespace :admin do
  	get 'top' => 'homes#top'
  	resources :users, only: [:index, :show, :edit, :update]
  	resources :posts
  	resources :genres, only: [:index, :create, :edit, :update]
  	resources :prefectures, only: [:index, :edit, :update]
  	resources :areas, only: [:index, :show, :create, :edit, :update]
  end

  devise_for :users, controllers: {
  	sessions: 'public/sessions',
    passwords: 'public/passwords',
    registrations: 'public/registrations'
  }

  scope module: :public do
  	root 'homes#top'
  	get 'about' => 'homes#about'
  	get 'confirm' => 'users#confirm'
  	put 'confirm' => 'users#withdraw'
    resources :users, only: [:show, :edit, :update]
  	resources :posts
  	resources :genres, only: [:index]
  	resources :prefectures, only: [:index]
  	resources :areas, only: [:index]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
