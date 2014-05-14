class Book < ActiveRecord::Base
  attr_accessible :title, :author, :publisher, :edition, :isbn
  belongs_to :user
end
