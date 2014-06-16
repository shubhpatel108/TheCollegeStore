class BooksController < ApplicationController
  before_filter :check_college, :only => [:index, :main_search]
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :sell_autofill]

  def index
    @book_groups = BookGroup.all
    $book_names = @book_groups.map(&:title)
    $categories = Category.all
    cat_ids = @book_groups.map(&:category_id)
    $categories.each do |cat|
      cat[:total_books] = cat_ids.count(cat.id)
    end
    college_id = cookies[:college_id]
    @book_groups.each do |group|
        group[:stock] = group.books.where(:college_id => college_id).count
        group[:min_price] = group.books.map(&:price).min
    end
    @latest = @book_groups.sort_by {|b| b[:updated_at]}.reverse!.slice(0..3)
    @popular = @book_groups.sort_by {|b| b[:stock]}.reverse!.slice(0..3)
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
    @book_group = @book.book_group
  end

  def update
    all = params
    @book = Book.find(all[:id])
    @bg = @book.book_group
    @book_group = @book.book_group
    if not @book.update_attributes(:edition => all[:edition], :isbn => all[:isbn], :price => all[:price])
      flash[:error] = "Something is wrong! Try again."
      render 'edit'
    else
      if @bg.title!=all[:title] or @bg.author!=all[:author] or @bg.publisher!=all[:publisher]
          @old_book_group = BookGroup.where(title: all[:title], author: all[:author], publisher: all[:publisher]).first
        if not @old_book_group.nil?
          @old_book_group.books << @book
          @book.book_group = @old_book_group
          @book.save
          @old_book_group.save
        else
          @new_bg = BookGroup.create(:title => all[:title], :author => all[:author], :publisher => all[:publisher])
          @new_bg.books << @book
          @book.book_group_id = @new_bg.id
          @book.save
          @new_bg.save
        end
      end
        flash[:success] = "Your Book's information has been updated!"
        redirect_to :books
    end
  end

  def main_search
  	@query = params[:query]
    @results = BookGroup.where(["title like ? or author like ?", "%#{@query}%", "%#{@query}%"])
    @results.each do |b|
      b[:min_price] = b.books.map(&:price).min
      b[:stock] = b.books(&:college_id).count(cookies[:college_id])
    end
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
