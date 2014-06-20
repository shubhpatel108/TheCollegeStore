class AddPasswordFieldToCityVendor < ActiveRecord::Migration
  def change
  	add_column :city_vendors, :password, :string, null: false, default: ""
  end
end
