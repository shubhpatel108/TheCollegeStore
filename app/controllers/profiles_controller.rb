class ProfilesController < ApplicationController
	def show
	id = current_user.id
	user_name = current_user.first_name.strip
  	@user = User.where(:id => id, :first_name => user_name)
  	if not @user.nil?
	  		@my_books = Book.where(:user_id => id)
	  	if @user == current_user
	  		@bought = Book.where(:seller_id => id)
	  		@bought.each do |b|
	  			b[:info] = b.book_group
	  		end
	  	end
  	else
  		render file: 'public/404', status: 404, formats: [:html]
  	end
  end
end
