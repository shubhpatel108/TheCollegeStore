class ContactUsMailer < ActionMailer::Base
  default to: "thecollegestore@tcs.com"

  def email_us(name, email, message)
  	@name = name
  	@email = email
  	@message = message

  	mail(from: name, subject: 'Contact from TCS')
  end
end
