class Guest < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :first_name, :last_name, :mobile, :email, :college_id
end
