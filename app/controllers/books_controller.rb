class BooksController < ApplicationController
  before_filter :check_college, :only => [:index, :main_search]
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :sell_autofill]

  def index
    @book_groups = BookGroup.all
    $book_names = @book_groups.map(&:title)
    college_id = cookies[:college_id]
    @book_groups.each do |group|
        group[:stock] = group.books.where(:college_id => college_id).count
    end
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
    @results = BookGroup.where(["title like ? or author like ?", "%#{@query}%", "%#{@query}%"])
    respond_to do |format|
      format.html
    end
  end

  def sell_autofill
    titl = params[:book_title]
    if not titl.empty?
      @est_book = BookGroup.where(["title like ?", "%#{titl}%"]).first
    end
    respond_to do |format|
      format.js
    end
  end

  def sell
    @book = Book.new
  end

  def request_seller
    s_ids = params[:seller_ids]
    message = params[:message]
    BookMailer.request_seller(s_ids, current_user, message).deliver
    flash[:notice] = "Your mail has been sent, seller(s) will soon respond you."
    redirect_to :books
  end

  private
  def check_college
    if cookies[:college_id].nil? || cookies[:college_name].nil?
      flash[:warning] = "You need to choose your College!"
      redirect_to controller: 'application', action: 'check_cookies'
    end
  end
end
