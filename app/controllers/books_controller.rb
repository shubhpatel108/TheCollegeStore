class BooksController < ApplicationController

  def index
    $books = Book.all
    $book_names = $books.map(&:title)
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(params[:book])
    if @book.save
      flash[:success] = "Book is saved for selling purpose."
      redirect_to :root
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

  def main_search
  	@query = params[:query]
    @results = Book.where(["title like ? or author like ? or isbn like ?", "%#{@query}%", "%#{@query}%", "%#{@query}%"])
    respond_to do |format|
      format.html
    end
  end

  def sell_autofill
    titl = params[:book_title]
    if not titl.empty?
      @est_book = Book.where(["title like ?", "%#{@query}%"]).first
    end
    respond_to do |format|
      format.js
    end
  end

  def sell
    @book = Book.new
  end

  def request_seller
    email = params[:seller_email]
    BookMailer.request_seller(email).deliver
    redirect_to :root
  end

end
