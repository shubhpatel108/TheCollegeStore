class AddRoomToAdminUser < ActiveRecord::Migration
  def up
  	add_column :admin_users, :room, :string
  end

  def down
  	remove_column :admin_users, :room
  end
end
