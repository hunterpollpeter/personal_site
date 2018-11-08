TwitchEngine::Engine.routes.draw do
  root 'stream#index'

  get 'overlays',             to: 'overlays#index',   as: :twitch_overlays
  get 'overlays/new/:template_id',   to: 'overlays#create',  as: :create_twitch_overlay
  get 'overlays/:id',         to: 'overlays#show',    as: :twitch_overlay
  get 'overlays/:id/preview', to: 'overlays#preview', as: :twitch_overlay_preview
  get 'overlays/:id/edit',    to: 'overlays#edit',    as: :edit_twitch_overlay

  get 'templates/:id', to: 'overlays#template', as: :twitch_overlay_template
  get 'templates/:id/preview', to: 'overlays#preview_template', as: :twitch_overlay_template_preview

  get 'users/sign_out', to: 'users#sign_out', as: :user_sign_out

  devise_for :users, skip: :sessions, class_name: "TwitchEngine::User", controllers: { omniauth_callbacks: "twitch_engine/users/omniauth_callbacks" }
end
