class OurController < ApplicationController
  before_filter :authenticate_user!, only: [:recommend, :send_recommendation]

  def our_team

  end

  def contact_us

  end

  def terms
  	
  end

  def about_us
  	
  end

  def shipping

  end

  def disclaimer

  end

  def privacy_policy

  end

  def send_mail
	name = sanitize(params[:name])
	email = sanitize(params[:email])
	message = sanitize(params[:message])
  	ContactUsMailer.email_us(name, email, message).deliver
  	redirect_to '/', notice: 'Your message has successfully sent, we will contact you soon.'
  end

  def recommend
    #serve the recommendation page where user can invite using email
  end

  def send_recommendation
    email = sanitize(params[:email])
    if email.empty?
      flash[:error] = "You must enter an email."
      redirect_to :back
    else
      ContactUsMailer.recommend(email, current_user).deliver
      flash[:success] = "Successfully invited! You'll soon be rewarded."
      redirect_to :root
    end
  end

end
