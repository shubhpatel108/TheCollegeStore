class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	devise :omniauthable, :omniauth_providers => [:facebook]
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
									:first_name, :last_name
  # attr_accessible :title, :body

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

end
