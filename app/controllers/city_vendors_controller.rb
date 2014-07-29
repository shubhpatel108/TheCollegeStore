class CityVendorsController < ApplicationController
	before_filter :signed_in_vendor, only: [:edit, :update, :show]
	before_filter :correct_vendor, only: [:edit, :update]

	def show
		@city_vendor = CityVendor.find(params[:id])		
	end	

	def new
		@city_vendor = CityVendor.new
	end

	def create
		@city_vendor = CityVendor.new(params[:city_vendor])
		if @city_vendor.save
			sign_in_vendor @city_vendor
			flash[:success] = "Welcome to The College Store!"
			redirect_to @city_vendor
		else
			render "new"
		end
	end

	def edit
	end

	def update
		if @city_vendor.update_attributes(params[:city_vendor])
			flash[:success] = "Profile updated"
			redirect_to @city_vendor
		else
			render 'edit'
		end
	end

	def new_password
		
	end

	def reset_password
		vendor = CityVendor.find_by_email(params[:email])
		vendor.send_password_reset if vendor
		redirect_to root_url, notice: "Email sent with password reset instructions."
	end

	def edit_password
		@city_vendor = CityVendor.find_by_password_reset_token!(params[:id])
	end

	def update_password
		@city_vendor = CityVendor.find_by_password_reset_token!(params[:id].to_s)
		if @city_vendor.password_reset_sent_at < 2.hours.ago
			redirect_to new_vendor_password_path, alert: "password reset has expired."
		elsif @city_vendor.update_attributes(params[:city_vendor])
			@city_vendor.update_attribute(:password_reset_token, CityVendor.new_auth_token)
			redirect_to root_url, notice: "Password has been reset."
		else
			render :edit
		end
	end

	private
		def correct_vendor
			@city_vendor = CityVendor.find(params[:id])
			redirect_to(root_url) unless current_vendor?(@city_vendor)
		end
end
