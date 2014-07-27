class AddIndexToCityVendorsEmail < ActiveRecord::Migration
  def change
  	add_index :city_vendors, :email, unique: true
  end
end
