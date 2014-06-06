class AddUserIdToCoupons < ActiveRecord::Migration
  def up
  	add_column :coupons, :user_id, :integer
  	add_index :coupons, :user_id
  end

  def down
  	remove_index :coupons, :user_id
  	remove_column :coupons, :user_id
  end
end
