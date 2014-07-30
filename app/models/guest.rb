class Guest < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :mobile, :email, :college_id
  has_and_belongs_to_many :coupons, :join_table => :distributed_coupons, :foreign_key => "user_id", :conditions => proc { "by_guest = true" }
	
	def daiictian?
		self.college_id == 1
	end
end
