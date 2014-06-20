class Book < ActiveRecord::Base
  attr_accessible :edition, :isbn, :price
  validates :price, presence: true, :numericality => true
  validates :edition, :numericality => true
  attr_accessible :reserved, :sold, :buyer_id

  belongs_to :user
  belongs_to :city_vendor
  belongs_to :college
  belongs_to :book_group
end
