class RenameDateColumnToPosts < ActiveRecord::Migration[5.1]
  def change
  	rename_column :posts, :date, :date_from
  	add_column :posts, :date_to, :date
  end
end
