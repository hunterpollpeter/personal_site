module TwitchEngine
  class Overlay < ApplicationRecord
    belongs_to :twitch_user
  end
end