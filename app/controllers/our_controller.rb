class OurController < ApplicationController

  def our_team

  end

  def contact_us

  end

  def terms
  	
  end

  def about_us
  	
  end

  def method_name
  	
  end

  def send_mail
	name = params[:name]
	email = params[:email]
	message = params[:message]
  	ContactUsMailer.email_us(name, email, message).deliver
  	redirect_to '/', notice: 'Your message has successfully sent, we will contact you soon.'
  end

end
