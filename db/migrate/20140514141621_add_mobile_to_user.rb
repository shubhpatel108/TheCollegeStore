class AddMobileToUser < ActiveRecord::Migration
  def up
  	add_column :users, :mobile, :string, :limit => 20
  end

  def down
  	remove_column :users, :mobile
  end
end
