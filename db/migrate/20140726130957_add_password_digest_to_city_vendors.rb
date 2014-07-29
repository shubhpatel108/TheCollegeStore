class AddPasswordDigestToCityVendors < ActiveRecord::Migration
  def change
    add_column :city_vendors, :password_digest, :string
  end
end
