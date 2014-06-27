class Distributor < ActiveRecord::Base
  attr_accessible :name, :address, :email, :image_name
  has_many :coupons
end
