class CreateRecommendations < ActiveRecord::Migration
  def up
    create_table :recommendations do |t|
    	t.integer :recommender_id, :null => false
    	t.string :recommended_id, :null => false
      t.timestamps
    end
  end

  def down
  	drop_table :recommendations
  end
end
