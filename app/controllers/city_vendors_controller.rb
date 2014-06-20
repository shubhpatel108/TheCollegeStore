class CityVendorsController < ApplicationController
	def new
		@city_vendor = CityVendor.new
	end

	def create
		@city_vendor = CityVendor.new(params[:city_vendor])
		if @city_vendor.save
			redirect_to :root, :notice => "Successfully signed up."
		else
			render "login"
		end
	end

	def login
		
	end

	def auth
		city_vendor = CityVendor.authenticate(params[:email], params[:password])
		if city_vendor
			session[:city_vendor_id] = city_vendor.id
			redirect_to :root, :notice => "You have successfully logged in."
		else
			flash.now.alert = "Invalid email or password"
			render "login"
		end
	end

	def logout
		session[:city_vendor_id] = nil
		redirect_to :root, :notice => "You are successfully logged out."
	end
	
	private
	def current_city_vendor
		@current_city_vendor ||= CityVendor.find_by_id(session[:city_vendor_id]) if session[:city_vendor_id]
	end
end
