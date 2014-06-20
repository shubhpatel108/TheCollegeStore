class Book < ActiveRecord::Base
  attr_accessible :edition, :isbn, :price, :user_id, :college_id, :book_group_id
  validates :price, presence: true, :numericality => true
  validates :edition, :numericality => true
  attr_accessible :reserved, :sold, :buyer_id

  belongs_to :user
  belongs_to :city_vendor
  belongs_to :college
  belongs_to :book_group
  belongs_to :admin_user

  scope :unsold, where(:reserved => false)
end
