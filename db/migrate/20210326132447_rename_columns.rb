class RenameColumns < ActiveRecord::Migration[5.2]
  def change
    rename_column :comments, :write_id, :sentence_id
    rename_column :likes, :write_id, :sentence_id
    rename_column :post_tags, :write_id, :sentence_id
  end
end
