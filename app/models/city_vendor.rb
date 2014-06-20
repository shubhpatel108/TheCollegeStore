class CityVendor < ActiveRecord::Base
  before_save :encrypt_password
  before_create { generate_token(:auth_token) }
  validates_presence_of :password, :on => :create 
  validates_presence_of :email
  validates_uniqueness_of :email
  attr_accessible :mobile, :vendor_name, :city, :email, :password_hash, :password_salt, :password
  attr_accessor :password, :remember_me
  has_many :books
  
  def self.authenticate(email, password)
  	vendor = find_by_email(email)
  	if vendor && vendor.password_hash == BCrypt::Engine.hash_secret(password, vendor.password_salt)
  		vendor
  	else
  		nil
  	end
  end

  def encrypt_password
  	if password.present?
  		self.password_salt = BCrypt::Engine.generate_salt
  		self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
  	end
  end
end
