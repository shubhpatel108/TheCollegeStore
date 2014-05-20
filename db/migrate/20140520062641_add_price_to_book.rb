class AddPriceToBook < ActiveRecord::Migration
  def up
  	add_column :users, :price, :integer
  end

	def down
  	remove_column :users, :price
  end  
end
