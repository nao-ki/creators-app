class PostTags < ActiveRecord::Migration[5.2]
  def change
    create_table :post_tags do |t|

      t.integer :image_id
      t.integer :write_id
      t.integer :sound_id
      t.integer :video_id
      t.integer :tag_id
      t.timestamps
    end
  end
end
