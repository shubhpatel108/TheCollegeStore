class AddImageNameToCategory < ActiveRecord::Migration
  def up
  	add_column :categories, :image_name, :string
  end

  def down
  	remove_column :categories, :image_name
  end
end
