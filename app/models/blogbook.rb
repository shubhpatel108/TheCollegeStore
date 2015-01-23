class Blogbook < ActiveRecord::Base
  attr_accessible :book_group_id, :url
  belongs_to :book_group
end
