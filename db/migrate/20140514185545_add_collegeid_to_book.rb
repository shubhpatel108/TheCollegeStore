class AddCollegeidToBook < ActiveRecord::Migration
  def up
  	add_column :books, :college_id, :integer
  	add_index :books, :college_id
  end

  def down
  	remove_index :books, :college_id
  	remove_column :books, :college_id
  end
end
