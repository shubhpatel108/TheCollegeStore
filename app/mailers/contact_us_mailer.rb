class ContactUsMailer < ActionMailer::Base
  default to: "contact@thecollegestore.com"

  def load_settings
    @@smtp_settings = {
      :address              => "smtp.zoho.com",
      :port                 => "465",
      :domain               => "thecollegestore.in",
      :authentication       => "ssl",
      :user_name            => "contact@thecollegestore.in",
      :password             => "saq1sazx"
    }
  end

  def email_us(name, email, message)
    load_settings
  	@name = name
  	@email = email
  	@message = message
    mail(from: email, subject: 'Contact from TCS')
  end
end
