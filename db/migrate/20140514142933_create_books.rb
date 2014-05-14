class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|

    	t.string :title, null: false
    	t.string :author
    	t.string :publisher
    	t.string :edition
    	t.string :isbn

      t.timestamps
    end
  end
end
