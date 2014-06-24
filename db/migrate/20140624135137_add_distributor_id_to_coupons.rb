class AddDistributorIdToCoupons < ActiveRecord::Migration
  def up
  	add_column :coupons, :distributor_id, :integer
  	add_index :coupons, :distributor_id
  end

  def down
  	remove_index :coupons, :distributor_id
  	remove_column :coupons, :distributor_id
  end
end
