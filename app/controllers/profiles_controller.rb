class ProfilesController < ApplicationController
	def show
		id = params[:id]
  	@user = User.where(:id => id)
  	if not @user.nil?
	  		@my_books = Book.where(:user_id => @user.id)
	  	if @user == current.user
	  		@my_wishes = Wishlist.where(:user_id => @user.id).map(&:book_group_id)
	  		@bought = Book.where(:seller_id => @user.id)
	  		@bought.each do |b|
	  			b[:info] = b.book_group
	  		end
	  	end
  	else
  		render file: 'public/404', status: 404, formats: [:html]
  	end
  end
end
