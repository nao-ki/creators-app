class Writes < ActiveRecord::Migration[5.2]
  def change
    create_table :writes do |t|
      t.string :title
      t.string :content
      t.string :summary
      t.integer :user_id
      t.timestamps null: false
  end
end
end
