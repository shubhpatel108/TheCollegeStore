class Earning < ActiveRecord::Base
  attr_accessible :paid, :due, :user_id
  belongs_to :user
end
