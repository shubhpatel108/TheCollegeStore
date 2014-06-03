class CreateBookGroups < ActiveRecord::Migration
  def change
    create_table :book_groups do |t|

    	t.string :title, null: false
    	t.string :author
    	t.string :publisher

      t.timestamps
    end
  end
end
