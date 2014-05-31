class BookGroup < ActiveRecord::Base
  attr_accessible :title, :author, :publisher, :books_attributes
  validates :title, presence: true
  validates :author, presence: true
  has_many :books, :dependent => :destroy
  accepts_nested_attributes_for :books
end
