class CreateBooksByUsers < ActiveRecord::Migration
  def up
    create_table :books_by_users do |t|
    	t.integer :book_id
    	t.integer :user_id
    end
  end

  def down
  	drop_table :books_by_users
  end
end
