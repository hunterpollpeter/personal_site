Rails.application.routes.draw do
  mount TwitchEngine::Engine => "/twitch_engine"
end
