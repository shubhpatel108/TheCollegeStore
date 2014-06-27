class WishlistsController < ApplicationController
	before_filter :authenticate_user!
	def add
		@bg_id = params[:id]
		if not @bg_id.nil?
			Wishlist.create(:book_group_id => @bg_id, :user_id => current_user.id)
		else
			render :js => "FlashNotice('error', 'Can not add a Book with nil id!')"
		end
		respond_to do |format|
			format.js
		end
	end

	def remove
		@bg_id = params[:id]
		if not @bg_id.nil?
			Wishlist.where(:book_group_id => @bg_id, :user_id => current_user.id).first.destroy
		else
			render :js => "FlashNotice('error', 'Can not remove a Book with nil id!')"
		end
		respond_to do |format|
			format.js
		end
	end

	def show
	  @my_wishes = Wishlist.where(:user_id => current_user.id).map(&:book_group_id)
	end
end
