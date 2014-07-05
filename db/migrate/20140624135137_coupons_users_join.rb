class CouponsUsersJoin < ActiveRecord::Migration
  def up
    create_table :coupons_users do |t|
    	t.integer "coupon_id", 		:null => false
    	t.integer "user_id", 		:null => false
    end
    add_index :coupons_users, ["user_id", "coupon_id"]
  end

  def down
  	drop_table :coupons_users
  end
end
