class AddDaIdToUser < ActiveRecord::Migration
  def up
  	add_column :users, :da_id, :integer
  end

  def down
  	remove_column :users, :da_id
  end
end
