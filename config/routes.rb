Rails.application.routes.draw do
  get 'rooms/show'
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users

  resources :rooms

  get '/search' => 'search#search'
  root 'home#index'

  get '/about'=> 'home#about'

  resources :sounds do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
  end

  resources :sentences do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
  end

  resources :videos do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
  end

  resources :images do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
  end

  resources :icons

  resources :users do
    get 'images' => 'users#images'
    get 'videos' => 'users#videos'
    get 'sounds' => 'users#sounds'
    get 'sentences' => 'users#sentences'
    get '/likes' => 'users#likes'
    get '/following_works' => 'users#following_works'
    member do
      get :following, :followers
    end
  end


  resources :relationships, only: [:create, :destroy]


end
