class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

	devise :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
									:first_name, :last_name, :mobile, :college_id,
									:points, :da_roll
  # attr_accessible :title, :body

	attr_accessible :profile_pic
	has_attached_file :profile_pic, :styles => {:thumb => "100x100"}, :default_url => "/assets/missing.jpg"
	validates_attachment_content_type :profile_pic, :content_type => /\Aimage\/.*\Z/

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, :on => :create
  # validates :mobile, presence: true,
		# 			:numericality => true,
  #                	:length => { :minimum => 10, :maximum => 15 }
  validates :first_name, :last_name, :presence => true
  
  has_many :books, dependent: :destroy
  belongs_to :college
  has_and_belongs_to_many :coupons, :join_table => :distributed_coupons, :foreign_key => "user_id", :conditions => proc { "by_guest = false" }
	has_many :wishlists, :dependent => :destroy,
                       :foreign_key => "user_id"
  has_many :wishes, :through => :wishlists, :source => :wish, dependent: :destroy
  has_many :blogs, dependent: :destroy
  has_one :earning
	
	def self.find_for_google_oauth2(auth)
	  user = User.where(:provider => auth.provider, :authid => auth.uid).first
		if user
			user.profile_pic = process_uri(auth.info.image)
			user.save
			return user
		else
			registered_user = User.where(:email => 	auth.info.email).first
			if registered_user
				registered_user.profile_pic = process_uri(auth.info.image)
				registered_user.save
				return registered_user
			else
			user = User.new
		    user.provider = auth.provider
		    user.authid = auth.uid
		    user.email = auth.info.email
		    user.password = Devise.friendly_token[0,20]
		    user.first_name = auth.info.first_name
		    user.last_name = auth.info.last_name
		    user.profile_pic = process_uri(auth.info.image)
		    user.confirm!
		    user.save!
		    return user
		  end
	  end
	end

	def self.find_for_facebook_oauth(auth)
		user = User.where(:provider => auth.provider, :authid => auth.uid).first
		if user
			user.profile_pic = process_uri(auth.info.image)
			user.save
			return user
		else
			registered_user = User.where(:email => 	auth.info.email).first
			if registered_user
				registered_user.profile_pic = process_uri(auth.info.image)
				registered_user.save
				return registered_user
			else
				user = User.new
		    user.provider = auth.provider
		    user.authid = auth.uid
		    user.email = auth.info.email
		    user.password = Devise.friendly_token[0,20]
		    user.first_name = auth.info.first_name
		    user.last_name = auth.info.last_name
		    user.profile_pic = process_uri(auth.info.image)
		    user.confirm!
		    user.save!
		    return user
		  end
	  end
	end

  def daiictian?
  	self.college_id == 1
  end

  def verification_code
  end

  def verification_code=(nothing)
  end

  private
	def self.process_uri(uri)
		avatar_url = URI.parse(uri)
		avatar_url.scheme = 'https'
		avatar_url.to_s
	end
end
