class CollegesController < ApplicationController

	def index

	end

	def request_admin_to_add_college
		college_name = params[:college_name]
		email = params[:email]
		CollegeMailer.request_admin_to_add_college(email,college_name).deliver
		redirect_to :root
	end

end
