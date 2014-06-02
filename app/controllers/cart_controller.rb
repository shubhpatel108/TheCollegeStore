class CartController < ApplicationController
  def add_item
    book_id = params[:id]
    session[:cart] ||= []
    session[:cart] << book_id
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
    session[:cart].delete(@book_id)
    respond_to do |format|
      format.js
    end
  end
end
