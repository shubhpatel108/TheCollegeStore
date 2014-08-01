class AddMobileToAdminUsers < ActiveRecord::Migration
  def up
  	add_column :admin_users, :mobile, :string
  end

  def down
  	remove_column :admin_users, :mobile
  end
end
