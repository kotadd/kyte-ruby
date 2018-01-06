class ModifyUsersTable < ActiveRecord::Migration[5.1]
  def change
  	add_column :users, :favorite1, :integer
	add_column :users, :favorite2, :integer
	add_column :users, :favorite3, :integer
  end
end
