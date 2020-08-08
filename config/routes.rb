Rails.application.routes.draw do
  
  resources :posts do
    resource :likes, only: [:create, :destroy]
  end
  devise_for :users
  root 'posts#index'
  resources :users, :only => [:show, :index, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
  end





  get 'genres/break'
  get 'genres/pop'
  get 'genres/lock'
  get 'genres/hiphop'
  get 'genres/house'
  get 'genres/wacck'
  get 'genres/freestyle'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
