class RenameColumnNameOfCityVendor < ActiveRecord::Migration
  def up
  	rename_column :city_vendors, :password, :password_hash
  	add_column :city_vendors, :password_salt, :string, null: false, default: ""
  end

  def down
  end
end
