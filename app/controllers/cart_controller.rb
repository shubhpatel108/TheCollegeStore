class CartController < ApplicationController
  before_filter :check_user, :only => [:checkout]
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

  def checkout
    @books = Book.where(:id => session[:cart])
    groups = @books.map(&:book_group)
    users = @books.map(&:user)
    @seller_ids = users.map(&:id)
    @coupons = Coupon.where(:id => session[:coupons])
    @total = 0
    done = @books.zip(groups, users)
    done.each do |b, g, u|
      b[:info] = g
      b[:user] = u
      b.buyer_id = current_user.id
      @total += b.price
    end
    BookMailer.buyer_invoice(current_user, @books, @coupons).deliver
    flash[:success] = "You have successfully checked out!"
    session[:cart] = nil
  end

  private
  def check_user
    if not user_signed_in?
      render :template => '/guests/selection'
    end
  end
end
