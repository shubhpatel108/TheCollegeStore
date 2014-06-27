class CreateDistributors < ActiveRecord::Migration
  def up
    create_table :distributors do |t|
			t.string :name
			t.string :address
			t.string :email
			t.string :image_name    	
    end
  end

  def down
  	drop_table :distributors
  end
end
