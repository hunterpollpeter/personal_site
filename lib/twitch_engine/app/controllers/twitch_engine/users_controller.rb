module TwitchEngine
  class UsersController < ApplicationController
    def sign_out
      session.delete('warden.user.user.key')
      redirect_to root_path
    end

    def spotify_currently_playing
      render json: User.find_by(id: user_params[:id])&.spotify_currently_playing
    end

    private

    def user_params
      params.permit(%i[id])
    end
  end
end