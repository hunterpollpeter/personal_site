class AddUserIdToTwitchEngineOverlay < ActiveRecord::Migration[5.2]
  def change
    add_column :twitch_engine_overlays, :user_id, :integer
  end
end
