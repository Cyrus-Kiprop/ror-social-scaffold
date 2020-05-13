Rails.application.routes.draw do

  get 'friendships/index'
  get 'friendships/show'
  get 'friendships/create'
  patch 'friendships/update/:id', to: 'friendships#update', as: 'friendships_update'
  delete 'friendships/destroy/:id', to: 'friendships#destroy', as: 'friendships_destroy'
  root 'posts#index'

  devise_for :users

  resources :friendships, only: [:index, :show, :create, :destroy, :update]
  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
