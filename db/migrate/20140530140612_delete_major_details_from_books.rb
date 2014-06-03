class DeleteMajorDetailsFromBooks < ActiveRecord::Migration
  def up
  	remove_column :books, :title
  	remove_column :books, :author
  	remove_column :books, :publisher
  end

  def down
  	add_column :books, :publisher, :string
  	add_column :books, :author, :string
  	add_column :books, :title, :string
  end
end
