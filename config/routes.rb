Rails.application.routes.draw do
  get 'reviews/new'
  root to: 'pages#home'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  get '/uikit', to: 'pages#index'
  patch '/skills', to: 'skills#update'
  get '/account', to: 'pages#account'
  get '/cancel/:id', to: 'proposals#cancel', as: :cancel
  post '/accept_proposal', to: "proposals#accept", as: :accept_proposal
  post "/#{ENV['TELEGRAM_KEY']}", to: "telegram_webhook#index"
  get 'orders/:id', to: "orders#create_room", as: :create_room

  resources :bios, only: [:new, :create, :edit, :update]
  resources :skill, only: [:show, :new]

  resources :questions do
    resources :messages, only: [:index, :create]
    resources :proposals
  end

  resources :orders, only: [:create, :edit, :update] do
    resources :payments
    resources :reviews, only: [:new, :create]
  end

  # Stripe webhook endpoint creation
  mount StripeEvent::Engine, at: '/stripe-webhooks'
end
