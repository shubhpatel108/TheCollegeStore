class WishlistsController < ApplicationController
	before_filter :authenticate_user!, :only => [:show]
	def add
		@bg_id = params[:id]
		if current_user.nil?
			@message = "You need to sign in."
			@m_type = "warning"
		else
			if not @bg_id.nil?
				Wishlist.create(:book_group_id => @bg_id, :user_id => current_user.id)
				@message = "Successfully addded to your Wishlist!"
				@m_type = "success"
			else
				@message = "Can not add a Book with nil id!"
				@m_type = "error"
			end
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
	  @w_ids = Wishlist.where(:user_id => current_user.id).map(&:book_group_id)
	  @my_wishes = BookGroup.where(:id => @w_ids)
	end
end
