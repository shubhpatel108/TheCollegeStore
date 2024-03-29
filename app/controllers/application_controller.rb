require 'net/http'

class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :initialize_variables, :set_cache_buster
  include CityVendorSessionsHelper
  include SanitizerHelper
  include GoodreadsHelper

	def select_college
		if params[:college_id].nil?
			flash[:error] = "Please select your college."
			redirect_to :back
		else
			c_id = sanitize(params[:college_id])
			flash.keep
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
	end

	def check_cookies
		if params[:ref] == "main"
			@book_with_blogs = Blogbook.all.to_a.slice(0..3).map(&:book_group)
			if @book_with_blogs.empty?
				@book_with_blogs = BookGroup.all.slice(0..3)
			end
			render :template => 'shared/home'
		else
			@book_groups = BookGroup.all
			@book_with_blogs = Blogbook.all.to_a.slice(0..3).map(&:book_group)
			if @book_with_blogs.empty?
				@book_with_blogs = @book_groups.slice(0..3)
			end
			flash.keep
			if current_user.nil? and cookies[:college_id].nil?
					@colleges = College.all
					render :template => 'shared/home'
			elsif not current_user.nil?
				redirect_to :action => 'select_college', :college_id => current_user.college_id || cookies[:college_id]
			else
				redirect_to :books
			end
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
	if session[:value_remaining].nil?
		flash[:warning] = "You are not elligible for incentives!"
		redirect_to :back
	elsif session[:value_remaining] < 0
		flash[:warning] = "You are not elligible for incentives!"
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
