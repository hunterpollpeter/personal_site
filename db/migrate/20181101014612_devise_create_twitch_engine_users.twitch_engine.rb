# This migration comes from twitch_engine (originally 20181101012634)
class DeviseCreateTwitchEngineUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :twitch_engine_users do |t|
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string :uid,                null: false, default: ""
      t.string :username,           null: false, default: ""
      t.string :image_url,          null: false, default: ""
      t.string :token,              null: false, default: ""
      t.json   :data
      t.timestamps null: false
    end
  end
end
