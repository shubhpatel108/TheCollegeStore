class College < ActiveRecord::Base
  attr_accessible :name, :city
  has_many :users
  has_many :books
end
