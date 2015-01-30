class CreateBlogbooks < ActiveRecord::Migration
  def up
    create_table :blogbooks do |t|
    	t.integer :book_group_id, 	null: false
    	t.string :url, 						null: false 
      t.timestamps
    end
  end

  def down
  	drop_table :blogbooks
  end
end
