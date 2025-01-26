Rails.application.routes.draw do
  # Admin namespace com rotas para usuários
  namespace :admin do
    resources :users, only: [:index] do
      member do
        patch :approve # Rota PATCH para aprovar usuário
        patch :reject  # Rota PATCH para rejeitar usuário
      end
    end
  end

  # Rotas Devise para autenticação
  devise_for :users

  # Rotas para usuários
  resources :users, only: [:show]

  # Rotas para user_configs
  resources :user_configs do
    collection do
      get :library
    end
    member do
      post :save
    end
  end

  # Rotas para vídeos e banners
  resources :videos do
    resources :video_messages, only: [:create]
  end
  resources :banners

  # Rota raiz
  root to: "home#home"

  # Chatbot
  get "chatbot/show", to: "chatbot#show", as: :chatbot_show
  get "chat", to: "chatbot#show"
  post "chat", to: "chatbot#interact"

  # Rota para lives
  get 'lives/:id', to: 'lives#show', as: 'live'
end
