class AddExternalProviderToUser < ActiveRecord::Migration
  def up
  	add_column :users, :provider, :string
  	add_column :users, :authid, :integer
  end

  def down
  	remove_column :users, :authid
  	remove_column :users, :provider
  end
end
