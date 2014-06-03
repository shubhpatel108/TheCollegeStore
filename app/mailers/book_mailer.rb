class BookMailer < ActionMailer::Base
  default from: "no_reply@tcs.com"

  def request_seller(s_ids, buyer, message)
	@sellers = User.where(:id => s_ids)
	@seller_emails = @sellers.collect(&:email).join(",")
	@message = message
	@buyer_email = buyer.email
	@buyer_name = buyer.first_name + " " + buyer.last_name  	
  	mail(:to=>@seller_emails,:subject=>"Request to buy your book | TheCollegeStore")
  end

  def buyer_invoice(seller, books)
  	@email = seller.email
  	@name = seller.first_name + " " + seller.last_name
  	@books = books
  	mail(:to=>@email,:subject=>"Books purchased by you | TheCollegeStore")
  end
end
