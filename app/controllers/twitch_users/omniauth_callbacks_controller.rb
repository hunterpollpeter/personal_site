class TwitchUsers::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitch
    @user = TwitchUser.from_omniauth(request.env["omniauth.auth"])
    sign_in @user
    redirect_to root_path
  end

  def failure
    redirect_to root_path
  end
end