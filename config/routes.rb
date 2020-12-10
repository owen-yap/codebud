Rails.application.routes.draw do
  root to: 'pages#home'
  get '/uikit', to: 'pages#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/accept_proposal', to: "proposals#accept", as: :accept_proposal
  get '/account', to: 'pages#account'
  resources :bios, only: [:new, :create, :edit, :update]
  resources :skill, only: [:new]
  resources :questions do
    resources :proposals
  end
end
