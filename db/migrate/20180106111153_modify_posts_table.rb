class ModifyPostsTable < ActiveRecord::Migration[5.1]
  def change
  	add_column :posts, :title, :string
	add_column :posts, :date, :date
	add_column :posts, :time_from, :time
	add_column :posts, :time_to, :time
	add_column :posts, :place, :string
	add_column :posts, :budget, :integer
	add_column :posts, :max_member, :integer
	add_column :posts, :genre_id, :integer
	add_column :posts, :image_name, :string
  end
end
