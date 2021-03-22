class Comments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :text
      t.integer :write_id
      t.integer :image_id
      t.integer :video_id
      t.integer :sound_id
      t.integer :user_id
      t.timestamps null: false
  end
end
end
