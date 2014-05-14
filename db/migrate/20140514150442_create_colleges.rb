class CreateColleges < ActiveRecord::Migration
  def change
    create_table :colleges do |t|

    	t.string :name, null: false
    	t.string :city 

      t.timestamps
    end
  end
end
