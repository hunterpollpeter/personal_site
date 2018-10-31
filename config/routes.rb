Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  constraints subdomain: 'twitch' do
    root 'twitch/overlays#index'

    get 'overlays/new/:name', to: 'twitch/overlays#new', as: :new_twitch_overlay
    get 'overlays/:id', to: 'twitch/overlays#show', as: :twitch_overlay

    get 'templates/:name', to: 'twitch/overlays#template', as: :twitch_overlay_template

    devise_for :twitch_users, controllers: { omniauth_callbacks: 'twitch_users/omniauth_callbacks' }
  end

  root 'home#index'
end
