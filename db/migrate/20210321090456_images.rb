class Images < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.string :title
      t.string :content
      t.integer :user_id
      t.timestamps null: false
  end
end
end
