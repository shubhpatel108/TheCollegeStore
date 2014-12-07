require 'rubypress'

class BlogController < ApplicationController
	before_filter :authenticate_user!, only: [:new, :create]

	def index
		@@wp = Rubypress::Client.new(:host => "thecollegestore1.wordpress.com", 
		                             :username => "thecollegestore1", 
		                             :password => "thecollegestorethe")

		@posts = @@wp.getPosts( :filter => {
					            	:post_type => 'post',
				                	:orderby => 'post_date',
				                	:order => 'asc'
	                        	} )
	end

	def new

	end

	def create
		post_id = @@wp.newPost(  :blog_id => 1, # 0 unless using WP Multi-Site, then use the blog id
            				     :content => {
		                         	 :post_status  => "publish",
		                         	 :post_date    => Time.now,
		                         	 :post_content => params[:post][:content],
		                         	 :post_title   => params[:post][:title],
		                         	 :post_author  => 76554683, # 1 if there is only the admin user, otherwise the user's id
		                         	 :terms_names  => {
		                             	:category   => ['Category One','Category Two','Category Three'],
		                             	:post_tag => ['Tag One','Tag Two', 'Tag Three']
		                             }
	                         	 }
	            			   )
		Blog.create(:post_id => post_id, :user_id => current_user.id)
		redirect_to action: 'index'
	end

end
