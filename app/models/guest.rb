class Guest < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :mobile, :email, :college_id
end