Rails.application.routes.draw do
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
    resources :proposals
  end
  resources :orders do
    resources :payments
  end

  # Stripe webhook endpoint creation
  mount StripeEvent::Engine, at: '/stripe-webhooks'

  get '/cancel/:id', to: 'proposals#cancel', as: :cancel

  resources :users, only: [] do
    resources :messages, only: [:index, :create]
  end

  post '/1344893186:AAFwGnlTgTZyKzp-fjQIxIS4ZlyW-k3lOKQ', to: "telegram_webhook#index"
  # get '/users/:id/messages', to: 'messages#show' , as: :messages
  # resources :messages, only: [:create]



end
