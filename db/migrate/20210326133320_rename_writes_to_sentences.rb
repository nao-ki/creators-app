class RenameWritesToSentences < ActiveRecord::Migration[5.2]
  def change
    rename_table :writes, :sentences
  end
end
