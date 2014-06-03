class ApplicationController < ActionController::Base
  protect_from_forgery

	def select_college
		@college_id = params[:college_id]
		cookies[:college_id] = @college_id
		$college_name = College.where(:id => cookies[:college_id].to_s).first
	    $book_names = BookGroup.all.map(&:title)
  	redirect_to :controller => "books", :action => "index"
	end

	def check_cookies
		if cookies[:college_id].nil?
			@colleges = College.all
			render :partial => 'shared/person_category_form'
		else
			$college_name = College.where(:id => cookies[:college_id].to_s).first
			redirect_to :controller => "books", :action => "index"
		end
	end

end
