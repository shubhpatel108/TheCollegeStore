class AddAdminUserIdToBooks < ActiveRecord::Migration
  def up
  	add_column :books, :admin_user_id, :integer
  	add_index :books, :admin_user_id
  end

  def down
  	remove_index :books, :admin_user_id
  	remove_column :books, :admin_user_id
  end
end
