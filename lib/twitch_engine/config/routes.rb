TwitchEngine::Engine.routes.draw do
  root 'stream#index'

  get 'overlays', to: 'overlays#index', as: :twitch_overlays
  get 'overlays/new/:name', to: 'overlays#new', as: :new_twitch_overlay
  post 'overlays/new/:name', to: 'overlays#create', as: :create_twitch_overlay
  get 'overlays/:id', to: 'overlays#show', as: :twitch_overlay

  get 'templates/:name', to: 'overlays#template', as: :twitch_overlay_template

  get 'users/sign_out', to: 'users#sign_out', as: :user_sign_out

  devise_for :users, skip: :sessions, class_name: "TwitchEngine::User", controllers: { omniauth_callbacks: "twitch_engine/users/omniauth_callbacks" }
end
