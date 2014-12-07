class Book < ActiveRecord::Base
  attr_accessible :edition, :isbn, :price, :user_id, :college_id, :book_group_id, :admin_user_id, :by_guest
  validates :edition, :numericality => true,:allow_blank => true
  attr_accessible :reserved, :sold, :buyer_id

  belongs_to :user
  belongs_to :city_vendor
  belongs_to :college
  belongs_to :book_group
  belongs_to :admin_user
  belongs_to :buyer, :foreign_key => "buyer_id", :class_name => "User"

  scope :unsold, where(:reserved => false)

  def buyer
    if by_guest
      Guest.where(:id => buyer_id).first
    else
      User.where(:id => buyer_id).first
    end
  end
end
