class CartController < ApplicationController
  def add_item
    book_id = params[:id]
    book = Book.where(:id => book_id).first
    if book.reserved
      @message = "Oops! Someone recently purchased this Book before you!"
    else
      session[:cart] ||= []
      session[:cart] << book_id
      @message = "Your book has been successfully added to the cart!"
      book.reserved = true
      book.save!
    end
      respond_to do |format|
        format.js
      end
  end

  def show_cart
    @books = Book.where(:id => session[:cart])
    @books.each do |book|
      book[:group] = book.book_group
    end
    respond_to do |format|
      format.js
    end
  end

  def remove_item
    @book_id = params[:id]
    book = Book.where(:id => @book_id).first
    book.reserved = false
    book.save!
    session[:cart].delete(@book_id)
    respond_to do |format|
      format.js
    end
  end
end
