class Book < ActiveRecord::Base
  attr_accessible :edition, :isbn
  validates :edition, presence: true

  belongs_to :user
  belongs_to :college
  belongs_to :book_group
end
