class BookGroupsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create]
  
  def new
  	@book_group = BookGroup.new
    @book_group.books.build
  end

  def create
    @book_group = BookGroup.new(params[:book_group])
    @old_book_group = BookGroup.where(title: @book_group.title, author: @book_group.author, publisher: @book_group.publisher).first
    if not @old_book_group.nil?
      @book = Book.new(params[:book_group][:books_attributes]['0'])
      if not session[:city_vendor_id].nil?
        @new_book.user_id = session[:city_vendor_id]
        @new_book.save
      else
        @new_book.user_id = current_user.id
        @new_book.college_id = current_user.college_id
        @new_book.save
      end
      @old_book_group.books << @book
      @old_book_group.save
      BookMailer.notify_wishers(@old_book_group).deliver
      flash[:success] = "Your Book is added!"
      redirect_to :books
    else
      if @book_group.save
        @new_book = @book_group.books.last
        if not session[:city_vendor_id].nil?
          @new_book.user_id = session[:city_vendor_id]
          @new_book.save
        else
          @new_book.user_id = current_user.id
          @new_book.college_id = current_user.college_id
          @new_book.save
        end
        flash[:success] = "Your Book is added!"
        redirect_to :books
      else
        flash[:error] = "Something went wrong! Please try again"
        render :action => 'new'
      end
    end
  end

  def details
    @book_group = BookGroup.where(:id => params[:id]).first
    @book_category = @book_group.category.name
    @books = @book_group.books.where(:college_id => cookies[:college_id])
    @owners = []
    @books.each do |b|
      @owners << b.user
    end
    @wished = false
    if user_signed_in?
      w = Wishlist.where(:book_group_id => @book_group.id, :user_id => current_user.id).first
      if not w.nil?
        @wished = true
      end
    end
    @details = @books.zip(@owners)
  end

  def category_books
    @c_id = params[:id]
    @category = Category.where(:id => @c_id).first
    @books = BookGroup.where(:category_id => @c_id)
    respond_to do |format|
      format.js
    end
  end

  def all_categories
    @categories = Category.all
    respond_to do |format|
      format.html
    end
  end
end
