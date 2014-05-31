class AddImageToBookgroup < ActiveRecord::Migration
  def up
  	add_attachment :book_groups, :image
  end

  def down
  	remove_attachment :book_groups, :image
  end
end
