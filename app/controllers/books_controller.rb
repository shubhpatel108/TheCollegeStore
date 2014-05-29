class BooksController < ApplicationController

  def index
    @books = Book.all
    $book_names = @books.map(&:title)
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(params[:book])
    if @book.save
      flash[:success] = "Book is saved for selling purpose."
      redirect_to index_path
    else
      render 'new'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update_attributes(params[:book])
      redirect_to :root
    else
      render "edit"
    end
  end

  def search
  	@query = params[:query]
  	@results = current_user.goodreads_search(@query)
  end

end
