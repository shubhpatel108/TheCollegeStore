class CreateBooksByUsers < ActiveRecord::Migration
  def change
    create_table :books_by_users do |t|
    	t.integer :book_id
    	t.integer :user_id
    end
  end
end
