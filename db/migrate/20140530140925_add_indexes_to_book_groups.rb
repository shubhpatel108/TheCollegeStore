class AddIndexesToBookGroups < ActiveRecord::Migration
  def up
  	add_index :book_groups, :title
  	add_index :book_groups, :author
  end

  def down
  	remove_index :book_groups, :author
  	remove_index :book_groups, :title
  end
end
