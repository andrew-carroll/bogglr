Rails.application.routes.draw do
  get 'rat/index'
  get 'rat/edit'
  get 'rat/update'
  get 'rat/create'
  get 'rat/new'
  get 'rat/show'
  get 'rat/index'
  get 'rat/edit'
  get 'rat/update'
  get 'rat/create'
  get 'rat/new'
  get 'user_profiles/index'
  devise_for :users
  get 'homepage/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "homepage#index"

  get '/profile', to: 'user_profiles#index', as: 'user_profile'
  resources :rats, only: [:create, :update, :edit, :new, :show]
end
