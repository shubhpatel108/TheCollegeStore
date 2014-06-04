class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

	devise :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
									:first_name, :last_name, :mobile, :college_id
  # attr_accessible :title, :body

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :mobile, presence: true,
					:numericality => true,
                 	:length => { :minimum => 10, :maximum => 15 }
  validates :first_name, :last_name, :presence => true
  
  has_many :books
  belongs_to :college

	def self.find_for_google_oauth2(auth)
	  where(auth.slice(:provider, :authid)).first_or_create do |user|
	    user.provider = auth.provider
	    user.authid = auth.uid
	    user.email = auth.info.email
	    user.password = Devise.friendly_token[0,20]
	    user.first_name = auth.info.first_name
	    user.last_name = auth.info.last_name
	  end
	end

	def self.find_for_facebook_oauth(auth)
	  where(auth.slice(:provider, :authid)).first_or_create do |user|
	    user.provider = auth.provider
	    user.authid = auth.uid
	    user.email = auth.info.email
	    user.password = Devise.friendly_token[0,20]
	    user.first_name = auth.info.first_name
	    user.last_name = auth.info.last_name
	  end
	end

  def goodreads_search(query)
  	search = $gr_client.search_books(query)
  	search.results.work
  end

  def daiictian?
  	self.college_id == 1
  end
end
