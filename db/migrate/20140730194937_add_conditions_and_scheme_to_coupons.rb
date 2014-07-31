class AddConditionsAndSchemeToCoupons < ActiveRecord::Migration
  def up
  	add_column :coupons, :scheme, :string
  	add_column :coupons, :conditions, :string
  end

  def down
  	remove_column :coupons, :scheme
  	remove_column :coupons, :conditions
  end
end
