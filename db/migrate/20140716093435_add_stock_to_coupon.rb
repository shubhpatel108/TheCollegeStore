class AddStockToCoupon < ActiveRecord::Migration
  def change
  	add_column :coupons, :stock, :integer, :default => 0
  	remove_column :coupons, :distributed
  end
end
