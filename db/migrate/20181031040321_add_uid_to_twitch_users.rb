class AddUidToTwitchUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :twitch_users, :uid, :string
  end
end
