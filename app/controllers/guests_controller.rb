class GuestsController < ApplicationController
	
	def new
		@guest = Guest.new
	end

	def create
		@guest = Guest.new(params[:guest])
		if @guest.save
			session[:email] = @guest.email
			session[:college_id] = @guest.college_id
			redirect_to '/coupons'
		else
			redirect_to '/new_guest'
		end
	end

end
