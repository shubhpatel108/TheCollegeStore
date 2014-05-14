class AddUseridToBook < ActiveRecord::Migration
  def up
  	add_column :books, :user_id, :integer
  	add_index :books, :user_id
  end

  def down
  	remove_index :books, :user_id
  	remove_column :books, :user_id
  end
end
