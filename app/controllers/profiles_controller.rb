class ProfilesController < ApplicationController
	before_filter :authenticate_user!
	
	def show
		id = params[:id]
		fn = params[:first_name]
		ln = params[:last_name]
		@user = User.where(:id => id, :first_name => fn, :last_name => ln).first
		if not @user.nil?
				@my_books = Book.where(:user_id => id)
				@my_books.each do |b|
					b[:info] = b.book_group
				end
			if @user == current_user
				@bought = Book.where(:buyer_id => id)
				@bought.each do |b|
					b[:info] = b.book_group
				end
			end
		else
		render file: 'public/404', status: 404, formats: [:html]
	  	end
  	end

  	def orders
  		@ordered = Book.where(:buyer_id => current_user.id)
  		@ordered.each do |b|
  			b[:info] = b.book_group
  		end
  	end
end
