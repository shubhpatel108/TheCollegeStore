class CityVendorSessionsController < ApplicationController

	def new
		
	end

	def create
		vendor = CityVendor.find_by_email(params[:session][:email].downcase)
		if vendor && vendor.authenticate(params[:session][:password])
			sign_in_vendor vendor
			redirect_back_or vendor
		else		
			flash.now[:error] = 'Invalid email/password combination'
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to city_vendor_signin_url
	end
end
