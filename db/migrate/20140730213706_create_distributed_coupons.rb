class CreateDistributedCoupons < ActiveRecord::Migration
  def up
    create_table :distributed_coupons do |t|
    	t.integer :coupon_id, :null => false
    	t.integer :user_id, :null => false
    	t.string :code, :null => false
      t.timestamps
    end
    add_index :distributed_coupons, :coupon_id
    add_index :distributed_coupons, :user_id
  end

  def down
  	drop_table :distributed_coupons
  end
end
