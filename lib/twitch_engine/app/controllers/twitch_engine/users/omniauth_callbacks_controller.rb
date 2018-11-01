module TwitchEngine
  class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    layout 'twitch_engine/application'

    def twitch
      @user = User.from_omniauth(request.env["omniauth.auth"])
      sign_in @user
      redirect_to root_path
    end

    def failure
      redirect_to root_path
    end
  end
end