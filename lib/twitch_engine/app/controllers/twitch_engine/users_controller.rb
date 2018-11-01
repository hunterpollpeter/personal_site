module TwitchEngine
  class UsersController < ApplicationController
    def sign_out
      session.delete('warden.user.user.key')
      redirect_to root_path
    end
  end
end