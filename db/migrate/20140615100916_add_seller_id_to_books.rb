class AddSellerIdToBooks < ActiveRecord::Migration
  def up
  	add_column :books, :buyer_id, :integer
  	add_index :books, :buyer_id
  end

  def down
  	remove_index :books, :buyer_id
  	remove_column :books, :buyer_id
  end
end
