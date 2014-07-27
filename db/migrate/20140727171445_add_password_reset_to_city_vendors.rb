class AddPasswordResetToCityVendors < ActiveRecord::Migration
  def change
    add_column :city_vendors, :password_reset_token, :string
    add_column :city_vendors, :password_reset_sent_at, :datetime
  end
end
