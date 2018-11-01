Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  constraints subdomain: 'twitch' do
    mount TwitchEngine::Engine => "/"
  end

  root 'home#index'
end
