class ApiController < ApplicationController
	def colleges
		@colleges = College.all
		if @colleges.empty?
			render json: "No Colleges"
		else
			render json: @colleges
		end
	end

	def book_groups
		@book_groups = BookGroup.all
		if @book_groups.empty?
			render json: "No BookGroup added yet!"
		else
			render json: @book_groups
		end
	end

	def book_group
		id = params[:book_group_id]
		@bg = BookGroup.where(:id => id).first
		if @bg.nil?
			render json: "No Such BookGroup"
		else
			render json: @bg
		end
	end

	def bg_books
		bg_id = params[:book_group_id]
		college_id = params[:college_id]
		@books = Book.where(:book_group_id => bg_id, :college_id => college_id)
		if @books.empty?
			render json: "No Books for the BookGroup"
		else
			render json: @books
		end
	end
end
