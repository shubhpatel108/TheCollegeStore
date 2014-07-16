class Coupon < ActiveRecord::Base
  attr_accessible :code, :distributed, :distributor_id, :stock, :value
  has_and_belongs_to_many :users
  belongs_to :distributor

  def self.out_of_stock
  	return self.stock==0
  end
end