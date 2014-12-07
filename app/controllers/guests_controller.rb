class GuestsController < ApplicationController
	
	def new
		@guest = Guest.new
	end

	def create
		@guest = Guest.new(sanitize_hash(params[:guest]))
		if @guest.save
			session[:guest] = @guest
			session[:college_id] = @guest.college_id
			redirect_to checkout_path
		else
			redirect_to '/new_guest'
		end
	end

end
