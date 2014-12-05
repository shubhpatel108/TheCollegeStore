class Recommendation < ActiveRecord::Base
  attr_accessible :recommender_id, :recommended_id
  belongs_to :recommender, :class_name => "User", :foreign_key => "recommender_id"
  belongs_to :recommended, :class_name => "User", :foreign_key => "recommended_id"
end
