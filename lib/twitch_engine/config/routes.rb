TwitchEngine::Engine.routes.draw do
  root 'stream#index'

  get 'overlays',             to: 'overlays#index',   as: :twitch_overlays
  get 'overlays/new/:template_id',   to: 'overlays#create',  as: :create_twitch_overlay
  get 'overlays/:id',         to: 'overlays#show',    as: :twitch_overlay
  get 'overlays/:id/preview', to: 'overlays#preview', as: :twitch_overlay_preview
  get 'overlays/:id/edit',    to: 'overlays#edit',    as: :edit_twitch_overlay
  post 'overlays/:id/update', to: 'overlays#update',  as: :update_twitch_overlay

  get 'templates/:id/preview', to: 'overlays#preview_template', as: :twitch_overlay_template_preview

  get 'users/sign_out', to: 'users#sign_out', as: :user_sign_out
  get 'users/:id/overlay_data', to: 'users#overlay_data', as: :user_overlay_data
  get 'users/:id/twitch_webhook/:topic', to: 'users#twitch_webhook_verify', as: :user_twitch_webhook_verify
  post 'users/:id/twitch_webhook/:topic', to: 'users#twitch_webhook', as: :user_twitch_webhook

  devise_for :users, skip: :sessions, class_name: "TwitchEngine::User", controllers: { omniauth_callbacks: "twitch_engine/users/omniauth_callbacks" }
end
