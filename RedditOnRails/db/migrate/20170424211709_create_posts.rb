class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :url
      t.text :content
      t.integer :sub_id, index: true
      t.integer :author_id, null: false, index: true

      t.timestamps
    end
  end
end
