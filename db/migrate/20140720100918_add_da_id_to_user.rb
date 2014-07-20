class AddDaIdToUser < ActiveRecord::Migration
  def up
  	add_column :users, :da_roll, :integer
  end

  def down
  	remove_column :users, :da_roll
  end
end
