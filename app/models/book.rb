class Book < ActiveRecord::Base
  attr_accessible :title, :author, :publisher, :edition, :isbn
  validates :title, presence: true
  validates :author, presence: true
  validates :edition, presence: true

  belongs_to :user
  belongs_to :college
end
