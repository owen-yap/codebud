Rails.application.routes.draw do
  get 'reviews/new'
  root to: 'pages#home'
  get '/uikit', to: 'pages#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  patch '/skills', to: 'skills#update'

  post '/accept_proposal', to: "proposals#accept", as: :accept_proposal
  get '/account', to: 'pages#account'
  resources :bios, only: [:new, :create, :edit, :update]
  resources :skill, only: [:show, :new]

  resources :questions do
    resources :messages, only: [:index, :create]
    resources :proposals
  end

  resources :orders do
    resources :payments
    resources :reviews, only: [:new, :create]
  end

  # Stripe webhook endpoint creation
  mount StripeEvent::Engine, at: '/stripe-webhooks'

  post "/#{ENV['TELEGRAM_KEY']}", to: "telegram_webhook#index"

  get '/cancel/:id', to: 'proposals#cancel', as: :cancel
end
