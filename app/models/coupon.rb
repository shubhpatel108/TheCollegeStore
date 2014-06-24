class Coupon < ActiveRecord::Base
  attr_accessible :code, :distributed
  has_and_belongs_to_many :users
  belongs_to :distributor
end