class ApplicationController < ActionController::Base
  protect_from_forgery

	def select_college
		c_id = params[:college_id]
		c_name = College.where(:id => c_id).first.name
		cookies[:college_id] = c_id
		cookies[:college_name] = c_name
	  	redirect_to :controller => "books", :action => "index"
	end

	def check_cookies
		@book_groups = BookGroup.all 
		$book_names = @book_groups.map(&:title)
	    $categories = Category.all
	    cat_ids = @book_groups.map(&:category_id)
	    $categories.each do |cat|
	      cat[:total_books] = cat_ids.count(cat.id)
	    end
		if current_user.nil? and cookies[:college_id].nil?
				@colleges = College.all
				render :template => 'shared/sellect_college'
		elsif not current_user.nil?
			redirect_to :action => 'select_college', :college_id => current_user.college_id
		else
			redirect_to :books
		end
	end

  private
  def check_user
    if not user_signed_in? and (session[:guest].nil?)
      flash[:error] = "Please Sign in or checkout as Guest"
      render :template => '/guests/selection'
    end
  end

  def is_cart_empty
	if session[:cart].nil?
		flash[:warning] = "Your cart is Empty!"
		redirect_to :back
	elsif session[:cart].empty?
		flash[:warning] = "Your cart is Empty!"
		redirect_to :back
	end
	rescue ActionController::RedirectBackError
		redirect_to :books
  end
end
