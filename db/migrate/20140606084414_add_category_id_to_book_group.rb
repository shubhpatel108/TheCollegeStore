class AddCategoryIdToBookGroup < ActiveRecord::Migration
  def up
  	add_column :book_groups, :category_id, :integer
  	add_index :book_groups, :category_id
  end

  def down
  	remove_index :book_groups, :category_id
  	remove_column :book_groups, :category_id
  end
end
