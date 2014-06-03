class AddBookgroupIdToBooks < ActiveRecord::Migration
  def up
  	add_column :books, :book_group_id, :integer
  	add_index :books, :book_group_id
  end

  def down
  	remove_index :books, :book_group_id
  	remove_column :books, :book_group_id
  end
end
