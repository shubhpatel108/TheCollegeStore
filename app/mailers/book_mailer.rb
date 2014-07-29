class BookMailer < ActionMailer::Base
  default from: "sales@thecollegestore.in"

  def load_settings
    @@smtp_settings = {
      :address              => "smtp.zoho.com",
      :port                 => "465",
      :domain               => "thecollegestore.in",
      :authentication       => "ssl",
      :user_name            => "sales@thecollegestore.in",
      :password             => "sales@tcs",
      :enable_starttls_auto => false
    }
  end

  def request_seller(s_ids, buyer, message, bookdetail)
    load_settings
    @sellers = User.where(:id => s_ids)
    @seller_emails = @sellers.map(&:email)
    @message = message
    @bookdetail = bookdetail
    @buyer_email = buyer.email
    @buyer_name = buyer.first_name + " " + buyer.last_name
    mail(:to=>@seller_emails,:subject=>"Request to buy your book | TheCollegeStore")
  end

  def buyer_invoice(seller, books, coupons)
    load_settings
  	@email = seller.email
  	@name = seller.first_name + " " + seller.last_name
  	@books = books
    @books.each do |b|
      b[:info] = b.book_group
    end
    @coupons = coupons
  	mail(:to=>@email,:subject=>"Books purchased by you | TheCollegeStore")
  end

  def notify_wishers(bg)
    load_settings
    u_ids = Wishlist.where(:book_group_id => bg.id).map(&:user_id)
    wishers = User.where(:id => u_ids)
    @wisher_emails = wishers.collect(&:email).join(",")
    @book = bg
    mail(:to=>@wisher_emails, :subject => "#{bg.title} is recently added by a seller")
  end
end
