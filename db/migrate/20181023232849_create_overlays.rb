class CreateOverlays < ActiveRecord::Migration[5.2]
  def change
    create_table :overlays do |t|
      t.integer :overlay_template_id
      t.json :options
    end
  end
end
