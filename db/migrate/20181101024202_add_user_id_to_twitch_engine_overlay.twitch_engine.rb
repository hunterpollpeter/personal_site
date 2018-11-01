# This migration comes from twitch_engine (originally 20181101024008)
class AddUserIdToTwitchEngineOverlay < ActiveRecord::Migration[5.2]
  def change
    add_column :twitch_engine_overlays, :user_id, :integer
  end
end
