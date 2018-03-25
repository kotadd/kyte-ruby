class AddAvatarToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :avatar, :string
    remove_column :users, :image_name, :string
  end
end
