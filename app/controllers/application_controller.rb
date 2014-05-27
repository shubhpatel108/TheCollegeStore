class ApplicationController < ActionController::Base
  protect_from_forgery

  def person_category
  	@type = params[:type]
  	if @type == "student"
			redirect_to action: "student_form"
		elsif @type == "city_vendor"	
			respond_to do |format|
		   	format.js
		  end
		end
  end

  def student_form
  	@student = User.new
  	respond_to do |format|
  		format.js
  	end
  end

end
