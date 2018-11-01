module TwitchEngine
  class User < ApplicationRecord
    devise :database_authenticatable, :omniauthable, :omniauth_providers => [:twitch]
    has_many :overlays

    def self.from_omniauth(auth)
      where(uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.username = auth.info.nickname
        user.image_url = auth.info.image
        user.token = auth.credentials.token
        user.data = auth
      end
    end
  end
end
