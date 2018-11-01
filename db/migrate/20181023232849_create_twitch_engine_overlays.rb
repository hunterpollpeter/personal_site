class CreateTwitchEngineOverlays < ActiveRecord::Migration[5.2]
  def change
    create_table :twitch_engine_overlays do |t|
      t.string :name
      t.string :template_name
      t.json :options
      t.timestamps
    end
  end
end
