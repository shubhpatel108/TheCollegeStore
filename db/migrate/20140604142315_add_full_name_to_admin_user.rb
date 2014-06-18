class AddFullNameToAdminUser < ActiveRecord::Migration
  def up
  	add_column :admin_users, :full_name, :string
  end

  def down
  	remove_column :admin_users, :full_name
  end
end
