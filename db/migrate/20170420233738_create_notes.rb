class CreateNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :notes do |t|
      t.integer :user_id, null: false, index: true
      t.integer :track_id, null: false, index: true
      t.text :text, null: false

      t.timestamps
    end
  end
end
