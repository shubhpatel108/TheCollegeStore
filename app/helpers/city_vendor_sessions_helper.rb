module CityVendorSessionsHelper
	def sign_in_vendor(vendor)
		auth_token = CityVendor.new_auth_token
		if params[:session][:remember_me]
			cookies.permanent[:auth_token] = auth_token
		else
			cookies[:auth_token] = auth_token
		end
		vendor.update_attribute(:auth_token, CityVendor.digest(auth_token))
		self.current_vendor = vendor
	end

	def current_vendor=(vendor)
		@current_vendor = vendor
	end

	def current_vendor
		auth_token = CityVendor.digest(cookies[:auth_token])
		@current_vendor ||= CityVendor.find_by_auth_token(auth_token)
	end

	def current_vendor?(vendor)
		vendor == current_vendor
	end

	def vendor_signed_in?
		!current_vendor.nil?
	end

	def sign_out
		current_vendor.update_attribute(:auth_token, CityVendor.digest(CityVendor.new_auth_token)) if vendor_signed_in?
		cookies.delete(:auth_token)
		self.current_vendor = nil
	end

	def signed_in_vendor
		unless vendor_signed_in?
			store_location
			flash[:notice] = "Please sign in"
			redirect_to city_vendor_signin_url
		end
	end

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

	def store_location
		session[:return_to] = request.url if request.get?
	end
end
