class CreateAlbums < ActiveRecord::Migration[5.0]
  def change
    create_table :albums do |t|
      t.string :title, null: false
      t.integer :band_id, null: false, index: true
      t.string :album_type, null: false

      t.timestamps
    end
  end
end
