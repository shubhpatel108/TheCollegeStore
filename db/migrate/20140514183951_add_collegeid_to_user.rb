class AddCollegeidToUser < ActiveRecord::Migration
  def up
  	add_column :users, :college_id, :integer
  	add_index :users, :college_id
  end

  def down
  	remove_index :users, :college_id
  	remove_column :users, :college_id
  end
end
