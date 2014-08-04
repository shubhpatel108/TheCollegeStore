class BookMailer < ActionMailer::Base

  def load_settings
    @@smtp_settings = {
      :address              => "smtp.zoho.com",
      :port                 => 465,
      :user_name            => "contact@thecollegestore.in",
      :password             => "saq1sazx",
      :domain               => "thecollegestore.in",
      :authentication       => :login,
      :ssl                  => true
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
    mail(from: "contact@thecollegestore.in", :to=>@seller_emails,:subject=>"Request to buy your book | TheCollegeStore")
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
  	mail(from: "contact@thecollegestore.in", :to=>@email,:subject=>"Books purchased by you | TheCollegeStore")
  end

  def notify_wishers(bg)
    load_settings
    u_ids = Wishlist.where(:book_group_id => bg.id).map(&:user_id)
    wishers = User.where(:id => u_ids)
    wishers.each do |recipient|
      notify_individual_wisher(bg, recipient).deliver
    end
  end

  def notify_individual_wisher(bg, recipient)
    load_settings
    @book = bg
    mail(from: "sales@thecollegestore.in", :to=>recipient.email, :subject => "#{bg.title} is recently added by a seller", template_name: 'notify_individual_wisher')
  end
end
