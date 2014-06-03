class BookMailer < ActionMailer::Base
  default from: "valayvaidya28@gmail.com"

  def request_seller(email,message)
  	@email = email
  	@message = message
  	mail(:to=>email,:subject=>"Urgent::Request to buy your book")
  end

end
