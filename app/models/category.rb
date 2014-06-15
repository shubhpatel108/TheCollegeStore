class Category < ActiveRecord::Base
  attr_accessible :name, :image_name
  has_many :book_groups
end
