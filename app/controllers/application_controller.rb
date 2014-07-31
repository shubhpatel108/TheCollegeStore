class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :initialize_variables, :set_cache_buster
  include CityVendorSessionsHelper

	def select_college
		c_id = params[:college_id]
		@college = College.where(:id => c_id).first
		c_name = @college.name
		cookies[:college_id] = c_id
		cookies[:college_name] = c_name
		if not current_user.nil?
			current_user.college = @college
			current_user.save!
		end
	  	redirect_to :controller => "books", :action => "index"
	end

	def check_cookies
		@book_groups = BookGroup.all
		flash[:notice] = params[:flash] 
		if current_user.nil? and cookies[:college_id].nil?
				@colleges = College.all
				render :template => 'shared/sellect_college'
		elsif not current_user.nil?
			redirect_to :action => 'select_college', :college_id => current_user.college_id || cookies[:college_id], flash: flash
		else
			redirect_to :books, flash: flash
		end
	end

  private
  def check_user
    if not user_signed_in? and (session[:guest].nil?)
      flash[:error] = "Please Sign in or checkout as Guest"
      render :template => '/guests/selection'
    end
  end

  def is_cart_empty
	if session[:cart].nil?
		flash[:warning] = "Your cart is Empty!"
		redirect_to :back
	elsif session[:cart].empty?
		flash[:warning] = "Your cart is Empty!"
		redirect_to :back
	end
	rescue ActionController::RedirectBackError
		redirect_to :books
  end

  def initialize_variables
	if $book_names.nil?
		@book_groups = BookGroup.all
		$book_names = @book_groups.map(&:title)
	end
	session[:cart] ||= []
	session[:cart_total] ||= 0
  end

  def set_cache_buster
	response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
	response.headers["Pragma"] = "no-cache"
	response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
end
