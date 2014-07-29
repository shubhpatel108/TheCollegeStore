class CityVendor < ActiveRecord::Base
  has_many :books
  
  before_save { self.email = email.downcase }
  before_create :create_auth_token

  validates_presence_of :vendor_name, :mobile
  validates :email,  presence: true, uniqueness: { case_sensitive: false }
  attr_accessible :mobile, :vendor_name, :city, :email, :password, :password_confirmation
  
  has_secure_password
  validates :password, length: { minimum: 6 }

  def CityVendor.new_auth_token
    SecureRandom.urlsafe_base64
  end

  def CityVendor.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def send_password_reset
    self.password_reset_token = CityVendor.new_auth_token
    self.password_reset_sent_at = Time.zone.now
    save!(validate: false)
    CityVendorMailer.password_reset(self).deliver
  end

  private
    def create_auth_token
      self.auth_token = CityVendor.digest(CityVendor.new_auth_token)
    end
end
