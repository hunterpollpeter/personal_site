module TwitchEngine
  class ApplicationController < ActionController::Base
    layout 'twitch_engine/application'
    protect_from_forgery with: :exception
  end
end
