class CartController < ApplicationController
  before_filter :check_user, :only => [:checkout]
  def add_item
    book_id = params[:id]
    book = Book.where(:id => book_id).first
    session[:cart] ||= []
    if not session[:cart].include? book
      book[:group] = book.book_group
      book[:user] = book.user
      session[:cart] << book
      session[:cart_total] ||= 0
      session[:cart_total] += book.price
      @message = "Your book has been successfully added to the cart!"
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
    @book = Book.where(:id => @book_id).first
    if session[:cart].delete(@book)
      session[:cart_total] -= @book.price
    end
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
      if b.reserved
        b[:err] = true
      else
        b[:info] = g
        b[:user] = u
        if not current_user.nil?
          b.buyer_id = current_user.id
        end
        if not session[:guest].nil?
          b.buyer_id = session[:guest].id
          b.save
          b.by_guest = true
        end
        b.reserved = true
        b.save
        b[:err] = false
        @total += b.price
      end
    end
    BookMailer.buyer_invoice(current_user || session[:guest], @books, @coupons).deliver
    flash[:success] = "You have successfully checked out!"
    session[:cart] = nil
    session[:cart_total] = 0
  end

  private
  def check_user
    if not user_signed_in? and (session[:guest].nil?)
      render :template => '/guests/selection'
    end
  end
end
