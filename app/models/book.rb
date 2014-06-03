class Book < ActiveRecord::Base
  attr_accessible :edition, :isbn, :price
  validates :price, presence: true, :numericality => true
  validates :edition, :numericality => true

  belongs_to :user
  belongs_to :college
  belongs_to :book_group
end
