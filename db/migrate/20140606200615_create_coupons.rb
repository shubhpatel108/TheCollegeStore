class CreateCoupons < ActiveRecord::Migration
  def up
    create_table :coupons do |t|
    	t.string :code, :null => false
    	t.boolean :distributed, :default => false

      t.timestamps
    end
  end

  def down
  	drop_table :coupons
  end
end
