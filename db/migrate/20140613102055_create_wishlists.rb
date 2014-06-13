class CreateWishlists < ActiveRecord::Migration
  def change
    create_table :wishlists do |t|
    	t.integer "book_group_id", 	:null => false
    	t.integer "user_id", 		:null => false
    end
    add_index :wishlists, ["book_group_id", "user_id"]
  end

  def down
  	drop_table :wishlists
  end
end
