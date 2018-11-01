TwitchEngine::Engine.routes.draw do
  root 'overlays#index'

  get 'overlays/new/:name', to: 'overlays#new', as: :new_twitch_overlay
  post 'overlays/new/:name', to: 'overlays#create', as: :create_twitch_overlay
  get 'overlays/:id', to: 'overlays#show', as: :twitch_overlay

  get 'templates/:name', to: 'overlays#template', as: :twitch_overlay_template
end
