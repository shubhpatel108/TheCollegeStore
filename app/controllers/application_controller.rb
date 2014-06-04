class ApplicationController < ActionController::Base
  protect_from_forgery

	def select_college
		c_id = params[:college_id]
		c_name = College.where(:id => c_id).first.name
		cookies[:college_id] = c_id
		cookies[:college_name] = c_name
    $book_names = BookGroup.all.map(&:title)
  	redirect_to :controller => "books", :action => "index"
	end

	def check_cookies
		if current_user.nil? and cookies[:college_id].nil?
				@colleges = College.all
				render :partial => 'shared/person_category_form'
		elsif not current_user.nil?
			redirect_to :action => 'select_college', :college_id => current_user.college_id
		else
			redirect_to :controller => "books", :action => "index"
		end
	end

end
