class AddValueToCoupon < ActiveRecord::Migration
  def up
  	add_column :coupons, :value, :integer
  end

  def down
  	remove_column :coupons, :value
  end
end
