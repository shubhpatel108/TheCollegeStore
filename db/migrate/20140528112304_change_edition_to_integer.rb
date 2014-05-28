class ChangeEditionToInteger < ActiveRecord::Migration
  def up
  	change_column :books, :edition, :integer
  end

  def down
  	change_column :books, :edition, :string
  end
end
