class BookGroup < ActiveRecord::Base
  attr_accessible :title, :author, :publisher
  validates :title, presence: true
  validates :author, presence: true
end
