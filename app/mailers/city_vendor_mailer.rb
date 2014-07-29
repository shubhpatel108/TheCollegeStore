class CityVendorMailer < ActionMailer::Base
  default from: "from@example.com"

  def password_reset(vendor)
    @vendor = vendor    
    mail to: vendor.email, subject: "The College Store Password reset."
  end
end
