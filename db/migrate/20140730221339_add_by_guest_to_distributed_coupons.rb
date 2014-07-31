class AddByGuestToDistributedCoupons < ActiveRecord::Migration
  def up
  	add_column :distributed_coupons, :by_guest, :boolean, :default => false
  end

  def down
  	remove_column :distributed_coupons, :by_guest
  end
end
