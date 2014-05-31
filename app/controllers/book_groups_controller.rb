class BookGroupsController < ApplicationController
  
  def new
  	@book_group = BookGroup.new
    @book_group.books.build
  end

  def create
    @book_group = BookGroup.new(params[:book_group])
    @old_book_group = BookGroup.where(title: @book_group.title, author: @book_group.author, publisher: @book_group.publisher)
    if not @old_book_group.nil?
      @book = Book.new(params[:book_group][:books_attributes]['0'])
      @book.user_id = current_user.id
      @book.college_id = current_user.college_id
      @old_book_group.first.books << @book
      flash[:notice] = "your Book is added!"
      redirect_to :root
    else
      if @book_group.save
        flash[:notice] = "your Book is added!"
        redirect_to :root
      else
        render :action => 'new'
      end
    end
  end

end
