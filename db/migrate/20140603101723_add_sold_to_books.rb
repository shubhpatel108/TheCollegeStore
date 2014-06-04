class AddSoldToBooks < ActiveRecord::Migration
  def up
  	add_column :books, :sold, :boolean, default: false
  end

  def down
  	remove_column :books, :sold
  end
end
