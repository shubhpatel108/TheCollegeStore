class ContactUsMailer < ActionMailer::Base

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

  def email_us(name, email, message)
    load_settings
  	@name = name
  	@email = email
  	@message = message
    mail(from: "contact@thecollegestore.com", to: "contact@thecollegestore.com", subject: 'Contact from TCS')
  end
end
