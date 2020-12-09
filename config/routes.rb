Rails.application.routes.draw do
  get 'proposals/index'
  get 'proposals/new'
  get 'proposals/create'
  root to: 'pages#home'
  get '/uikit', to: 'pages#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/account', to: 'pages#account'
  resources :bios, only: [:new, :create, :edit, :update]
  resources :skill, only: [:new]
  resources :questions do
    resources :proposals
  end
end
