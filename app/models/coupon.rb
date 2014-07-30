class Coupon < ActiveRecord::Base
  attr_accessible :code, :distributed, :distributor_id, :stock, :value, :scheme, :conditions
  has_and_belongs_to_many :users, :join_table => :distributed_coupons, :foreign_key => "coupon_id"
  belongs_to :distributor

  def out_of_stock
  	return self.stock==0
  end

  def applicable(points)
  	return self.value < points
  end
end