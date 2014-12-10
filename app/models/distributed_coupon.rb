class DistributedCoupon < ActiveRecord::Base
  attr_accessible :coupon_id, :user_id, :code, :by_guest
  after_create :append_in_code

  belongs_to :coupon

  def append_in_code
	self.code = self.code + "DC" + "#{self.id}"
  end
end
