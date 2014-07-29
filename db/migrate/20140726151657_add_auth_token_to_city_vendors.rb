class AddAuthTokenToCityVendors < ActiveRecord::Migration
  def change
    add_column :city_vendors, :auth_token, :string
    add_index :city_vendors, :auth_token
  end
end
