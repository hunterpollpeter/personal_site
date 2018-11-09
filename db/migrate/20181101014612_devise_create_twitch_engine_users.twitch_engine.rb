# This migration comes from twitch_engine (originally 20181101012634)
class DeviseCreateTwitchEngineUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :twitch_engine_users do |t|
      t.string    :email
      t.string    :encrypted_password
      t.string    :uid
      t.string    :username
      t.string    :image_url
      t.string    :token
      t.json      :data
      t.string    :spotify_token
      t.string    :spotify_refresh_token
      t.datetime  :spotify_expires
      t.timestamps null: false
    end
  end
end
