module TwitchEngine
  class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def twitch
      @user = User.from_omniauth(request.env["omniauth.auth"])
      sign_in @user
      redirect_to root_path
    end

    def spotify
      current_user.spotify_credentials!(request.env["omniauth.auth"]&.fetch('credentials'))
      redirect_to root_path
    end

    def failure
      redirect_to root_path
    end
  end
end