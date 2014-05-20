class AddPriceToBook < ActiveRecord::Migration
  def up
  	add_column :books, :price, :integer
  end

	def down
  	remove_column :books, :price
  end  
end
