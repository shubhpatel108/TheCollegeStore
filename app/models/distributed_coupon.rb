class DistributedCoupon < ActiveRecord::Base
  attr_accessible :coupon_id, :user_id, :code
end
