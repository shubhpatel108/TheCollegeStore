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
      @book.user_id = current_user.id
      @book.college_id = current_user.college_id
      @book.save
      @old_book_group.books << @book
      @old_book_group.save
      flash[:success] = "Your Book is added!"
      redirect_to :books
    else
      if @book_group.save
        @new_book = @book_group.books.last
        @new_book.user_id = current_user.id
        @new_book.college_id = current_user.college_id
        @new_book.save
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
    @books = @book_group.books.where(:college_id => cookies[:college_id])
    @owners = []
    @books.each do |b|
      @owners << b.user
    end
    @details = @books.zip(@owners)
  end

  def category_books
    @c_id = params[:id]
    @category = Category.where(:id => @c_id)
    @books = BookGroup.where(:category_id => @c_id)
    respond_to do |format|
      format.js
    end
  end
end
