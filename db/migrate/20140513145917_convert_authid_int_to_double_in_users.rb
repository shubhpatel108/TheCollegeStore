class ConvertAuthidIntToDoubleInUsers < ActiveRecord::Migration
  def up
  	change_column :users, :authid, :double
  end

  def down
  	change_column :users, :authid, :integer
  end
end
