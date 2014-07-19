class Guest < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :mobile, :email, :college_id
	
	def daiictian?
		self.college_id == 1
	end
end
