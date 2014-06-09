class AddPointsToUser < ActiveRecord::Migration
  def up
  	add_column :users, :points, :integer
  end

  def down
  	remove_column :users, :points 
  end
end
