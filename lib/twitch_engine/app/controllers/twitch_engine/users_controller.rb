module TwitchEngine
  class UsersController < ApplicationController
    def sign_out
      session.delete('warden.user.user.key')
      redirect_to root_path
    end

    def overlay_data
      render json: User.find_by(id: user_params[:id]).overlay_data(params[:topics])
    end

    def twitch_webhook_verify
      render html: user_params[:hub_challenge], staus: 200
    end

    def twitch_webhook
      render nothing: true, status: 200, content_type: 'text/html'
    end

    private

    def user_params
      params.permit(%i[id hub_challenge])
    end
  end
end