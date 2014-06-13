class Wishlist < ActiveRecord::Base
  attr_accessible :book_group_id, :user_id
  belongs_to :wisher, :foreign_key => "user_id", :class_name => "User"
  belongs_to :wish, :foreign_key => "book_group_id", :class_name => "BookGroup"
end
