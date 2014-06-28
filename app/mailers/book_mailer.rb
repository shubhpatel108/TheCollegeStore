class BookMailer < ActionMailer::Base
  default from: "no_reply@tcs.com"

  def request_seller(s_ids, buyer, message, bookdetail)
	@sellers = User.where(:id => s_ids)
	@seller_emails = @sellers.collect(&:email).join(",")
	@message = message
  @bookdetail = bookdetail
	@buyer_email = buyer.email
	@buyer_name = buyer.first_name + " " + buyer.last_name
  	mail(:to=>@seller_emails,:subject=>"Request to buy your book | TheCollegeStore")
  end

  def buyer_invoice(seller, books, coupons)
  	@email = seller.email
  	@name = seller.first_name + " " + seller.last_name
  	@books = books
    @coupons = coupons
  	mail(:to=>@email,:subject=>"Books purchased by you | TheCollegeStore")
  end

  def notify_wishers(bg)
    u_ids = Wishlist.where(:book_group_id => bg.id).map(&:user_id)
    wishers = User.where(:id => u_ids)
    @wisher_emails = wishers.collect(&:email).join(",")
    @book = bg
    mail(:to=>@wisher_emails, :subject => "#{bg.title} is recently added by a seller")
  end
end
