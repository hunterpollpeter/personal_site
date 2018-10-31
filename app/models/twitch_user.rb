class TwitchUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable, :omniauth_providers => [:twitch]

  def self.from_omniauth(auth)
    twitch_user = TwitchUser.find_by(uid: auth.uid)
    return twitch_user unless twitch_user.nil?
    TwitchUser.create(uid: auth.uid,
                      email: auth.info.email,
                      password: Devise.friendly_token[0,20],
                      username: auth.info.nickname,
                      token: auth.credentials.token,
                      data: auth)
  end
end
