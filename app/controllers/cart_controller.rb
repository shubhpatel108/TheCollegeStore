class CartController < ApplicationController
  before_filter :check_user, :only => [:checkout]
  before_filter :is_cart_empty, :only => [:checkout, :remove_item]
  def add_item
    session[:cart] ||= []
    if session[:cart].count < 5
      book_id = params[:id]
      book = Book.where(:id => book_id).first
      if not session[:cart].include? book
        book[:group] = book.book_group
        book[:user] = book.user
        session[:cart] << book
        session[:cart_total] ||= 0
        session[:cart_total] += book.price
        session[:value_remaining] = session[:cart_total]
        @message = "Your book has been successfully added to the cart!"
        @m_type = "success"
      else
        @message = "This Book is already present in your cart!"
        @m_type = "notice"
      end
      respond_to do |format|
        format.js
      end
    else
      @message = "Your cart is full, you are allowed to add 5 books at a time!"
      respond_to do |format|
        format.js
      end
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
      session[:value_remaining] = session[:cart_total]
      @message = "Your book has been successfully remove to the cart!"
      @m_type = "success"
    else
      @message = "This Book is not present in your cart!"
      @m_type = "error"
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
    @coupons = Coupon.where(:id => session[:coupons])
    @coupons.each do |c|
      if not c.out_of_stock
        c.stock -= 1;
        c.save
        c[:err] = false
      else
        c[:err] = true
      end
    end
    BookMailer.buyer_invoice(current_user || session[:guest], @books, @coupons).deliver
    flash[:success] = "You have successfully checked out!"
    session[:cart] = nil
    session[:cart_total] = 0
    session[:coupons] = []
    session[:value_remaining] = 0
  end

end
