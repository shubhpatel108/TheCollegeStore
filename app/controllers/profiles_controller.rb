class ProfilesController < ApplicationController
	before_filter :authenticate_user!
	
	def show
		id = sanitize(params[:id])
		fn = sanitize(params[:first_name])
		ln = sanitize(params[:last_name])
		@user = User.where(:id => id, :first_name => fn, :last_name => ln).first
		if not @user.nil?
				@my_books = Book.where(:user_id => id)
				@my_books.each do |b|
					b[:info] = b.book_group
				end
			if @user == current_user
				@bought = Book.where(:buyer_id => id, :by_guest => false)
				@bought.each do |b|
					b[:info] = b.book_group
				end
			end
		else
		render file: 'public/404', status: 404, formats: [:html]
	  	end
  	end

	def show_profile
		@user = User.where(:id => params[:id]).first
        respond_to do |format|
          format.js
        end
  	end

  	def books_on_sale
  		id = params[:id]
		@books = Book.where(:user_id => id)
		@books.each do |b|
			b[:info] = b.book_group
		end
		respond_to do |format|
          format.js
        end
  	end

  	def books_purchased
  		id = params[:id]
		@bought = Book.where(:buyer_id => id, :by_guest => false)
		@bought.each do |b|
			b[:info] = b.book_group
		end
		respond_to do |format|
          format.js
        end
  	end

  	# This action is to show edit profiel page without loading page
  	def edit_profile
		respond_to do |format|
          format.js
        end
  	end

	def distributed_coupons
		@dist_info = DistributedCoupon.where(:user_id => current_user.id, :by_guest => false)
		respond_to do |format|
			format.js
		end
	end

end
