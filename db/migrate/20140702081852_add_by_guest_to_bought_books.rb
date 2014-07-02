class AddByGuestToBoughtBooks < ActiveRecord::Migration
  def up
  	add_column :books, :by_guest, :boolean, :default => false 
  end

  def down
  	remove_column :books, :by_guest 
  end
end
