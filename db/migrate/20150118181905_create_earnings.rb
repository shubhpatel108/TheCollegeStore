class CreateEarnings < ActiveRecord::Migration
  def change
    create_table :earnings do |t|
    	t.integer 	:user_id, 	null: false
    	t.integer		:paid, 			null: false
    	t.integer 	:due, 			null: false
      t.timestamps
    end
  end
end
