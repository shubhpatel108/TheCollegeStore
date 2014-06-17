class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
    	t.string :first_name,         null: false, default: ""
    	t.string :last_name,          null: false, default: ""
    	t.string :email,              null: false, default: ""
    	t.string :mobile,							:limit => 20
    	t.integer :college_id
      t.timestamps
    end
  end
end
