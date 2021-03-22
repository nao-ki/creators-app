class Likes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :write, foreign_key: true, null: true
      t.references :image, foreign_key: true, null: true
      t.references :sound, foreign_key: true, null: true
      t.references :video, foreign_key: true, null: true
      t.references :user, foreign_key: true, null: false
      t.timestamps
    end
  end
end
