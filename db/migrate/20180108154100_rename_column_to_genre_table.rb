class RenameColumnToGenreTable < ActiveRecord::Migration[5.1]
  def change
 	add_column :genres, :title, :string
    remove_column :genres, :user_title, :string
  end
end
