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
    @guest = session[:guest]
    done.each do |b, g, u|
      if b.reserved
        b[:err] = true
      else
        b[:info] = g
        b[:user] = u
        if not current_user.nil?
          b.buyer_id = current_user.id
          buyer_to_notify = current_user
        end
        if not session[:guest].nil?
          b.buyer_id = session[:guest].id
          b.save
          b.by_guest = true
          buyer_to_notify = session[:guest]
        end
        b.reserved = true
        b.save
        b[:err] = false
        @total += b.price

        #notify the buyer and send seller's contact
        url = URI.parse("http://sms.ssdindia.com/api/sendhttp.php?authkey=5863AO8VuQyUREU54882154&mobiles=#{buyer_to_notify.mobile}&message=Hi%2C%20thanks%20for%20purchasing.%20Please%20contact%20the%20seller%20#{b.user.first_name}%20#{b.user.last_name}%2C%20number%3A%20#{b.user.mobile}%20%26%20proceed%20with%20the%20transaction.%20Also%20checkout%20the%20handpicked%20coupon%20store.%20-TheCollegeStore.in&sender=clgstr&route=4")
        req = Net::HTTP::Get.new(url.to_s)
        res = Net::HTTP::start(url.host, url.port) {|http|
          http.request(req)
        }

        #notify the seller of the book
        url1 = URI.parse("http://sms.ssdindia.com/api/sendhttp.php?authkey=5863AO8VuQyUREU54882154&mobiles=#{b.user.mobile}&message=Hi%2C%20your%20listing%20has%20been%20purchased.%20Please%20contact%20the%20buyer%20#{buyer_to_notify.first_name}%20#{buyer_to_notify.last_name}%2C%20contact%20no.%20#{buyer_to_notify.mobile}%20and%20proceed%20with%20the%20transaction.%20Do%20visit%20our%20coupons%20section%20for%20handpicked%20exciting%20store%20coupons.%20-TheCollegeStore.in&sender=clgstr&route=4")
        req1 = Net::HTTP::Get.new(url1.to_s)
        res1 = Net::HTTP::start(url1.host, url1.port) {|http|
          http.request(req1)
        }

      end
    end
    @coupons = Coupon.where(:id => session[:coupons])
    @coupons.each do |c|
      if not c.out_of_stock
        d_coupon = DistributedCoupon.new(:coupon_id => c.id)
        if current_user.nil?
          d_coupon.user_id = session[:guest].id
          d_coupon.by_guest = true
        else
          d_coupon.user_id = current_user.id
        end
        d_coupon.code = c.generate_code(d_coupon.user_id, d_coupon.by_guest)
        d_coupon.save!
        c[:dist_code] = d_coupon.code
        c[:distributor_info] = c.distributor
        c.stock -= 1;
        c.save
        c[:err] = false
      else
        c[:err] = true
      end
    end
    BookMailer.buyer_invoice(current_user || session[:guest], @books, @coupons).deliver
    flash[:success] = "You have successfully checked out!"
    session[:cart] = []
    session[:cart_total] = 0
    session[:coupons] = []
    session[:value_remaining] = 0
    session[:guest] = nil
  end

end
