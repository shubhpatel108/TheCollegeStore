class ContactUsMailer < ActionMailer::Base
  default to: "thecollegestore@tcs.com"

  def email_us(name, email, subject, message)
  	@name = name
  	@email = email
  	@subject = subject
  	@message = message

  	mail(from: name, subject: 'Contact from TCS')
  end
end
