class College < ActiveRecord::Base
  attr_accessible :name, :city
  has_many :users
  has_many :books
  has_and_belongs_to_many :book_groups, :join_table => :college_books
end
