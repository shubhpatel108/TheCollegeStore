class BooksByUser < ActiveRecord::Base
  attr_accessible :book_id, :user_id

  def self.present?(book_id)
  	return (not BooksByUser.find_by_book_id(book_id).nil?)
  end
end
