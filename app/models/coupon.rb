class Coupon < ActiveRecord::Base
  attr_accessible :code, :distributed
  belongs_to :user
  belongs_to :distributor
end