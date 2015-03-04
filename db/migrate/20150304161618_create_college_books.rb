class CreateCollegeBooks < ActiveRecord::Migration
  def change
    create_table :college_books do |t|
  		t.integer :book_group_id, null: false
  		t.integer :college_id, 		null: false
    end
  end

  def down
  	drop_table :college_books
	end
end
