class BooksController < ApplicationController
  before_filter :check_college, :only => [:index, :main_search]
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :sell_autofill]

  def index
    @book_groups = BookGroup.scoped
    college_id = cookies[:college_id]

    college_books = College.where(:id => college_id).first.book_groups
    @latest = college_books.sort_by {|b| b.last_updated(college_id)}.reverse!.slice(0..3)
    @popular = college_books.sort_by {|b| b.stock(college_id)}.reverse!.slice(0..3)
    taken_bookids = (@latest + @popular).map(&:id).compact

    num_remaining = 4 - @latest.length
    if num_remaining > 0
      num_remaining -= 1
      other_books = @book_groups.select do |b|
        if not taken_bookids.include?(b.id)
          b
        end
      end

      @latest += other_books.sort_by {|b| b.last_updated_on}.reverse!.slice(0..num_remaining)
      @popular += other_books.sort_by {|b| b.total_stock}.reverse!.slice(0..num_remaining)
    end

    @book_with_blogs = Blogbook.all.to_a.slice(0..3).map(&:book_group)
    if @book_with_blogs.empty?
      @book_with_blogs = @book_groups.sort_by {|b| b.total_stock}.reverse!.slice(0..3)
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
    @book_group = @book.book_group
    if @book.user!=current_user
      flash[:error] = "You are not authorize to edit this book!"
      redirect_to :books
    end
  end

  def update
    all = sanitize_hash(params)
    @book = Book.find(all[:id])
    if @book.nil?
      flash[:error] = "Book not Found!"
      redirect_to :books
    else
      if @book.user == current_user
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
      else
        flash[:error] = "You are not authorize to edit this book!"
      end
    end
  end

  def main_search
    @query = sanitize(params[:query])
    @results = BookGroup.where(["title like ? or author like ?", "%#{@query}%", "%#{@query}%"])
    @results.each do |b|
      temp_books = b.books
      b[:min_price] = temp_books.map(&:price).compact.min
      b[:stock] = temp_books.where(:college_id => cookies[:college_id], :reserved => false).where(Book.arel_table[:admin_user_id].not_eq(nil)).count
    end
    @original_query = @query
    @query = "Search results for \'" + @query + "\'"
    respond_to do |format|
      format.html
    end
  end

  def sell_autofill
    titl = sanitize(params[:book_title])
    if not titl.empty?
      @est_book = BookGroup.where(["title like ?", "#{titl}"]).first
      if @est_book.nil?
        render :js => ""
      else
        respond_to do |format|
          format.js
        end
      end
    else
      render :js => ""
    end
  end


  def isbn_autofill
    isbn = sanitize(params[:isbn_query])
    @est_book = Book.where(:isbn => isbn).first
    if @est_book.nil?
      @est_book = BookGroup.new
      results = goodreads_search(isbn)
      @est_book.title = results[:best_book][:title]
      @est_book.author = results[:best_book][:author][:name]
      @est_book.publisher = ""
    else
      @est_book = @est_book.book_group
    end
    respond_to do |format|
      format.js { render :template => "/books/sell_autofill.js.erb"}
    end
  end

  def sell
    @book = Book.new
  end

  def request_seller
    b_ids = params[:books_ids]
    message = sanitize(params[:message])
    if not current_user.nil?
      @user = current_user 
    else
      @user = session[:guest]
    end

    b_ids.each do |b|
      book = Book.where(:id => b).first
      if book.admin_user.nil? 
        BookMailer.request_seller(book.user_id, @user, message, book).deliver
      end
    end

    flash[:notice] = "Your mail has been sent, seller(s) will soon respond you."
    redirect_to :action => 'index'
  end

  def filter
    p = params
    if p[:category]!="All"
      p[:category] = Category.where(:name => p[:category]).first
    else
      p[:category] = nil
    end
    p[:author] = '' if p[:author]=="All"
    p[:publisher] = '' if p[:publisher]=="All"
    p[:price] = 10000 if p[:price]=="All"
    book_groups = BookGroup.where(["title like ? and author like ? and publisher like ?", "%#{p[:title]}%", "%#{p[:author]}%", "%#{p[:publisher]}%"])
    book_groups = book_groups.where(:category_id => p[:category]) unless p[:category].nil?
    @results = book_groups.to_a.dup

    book_groups.each do |bg|
      temp_books = bg.books
      if not temp_books.map(&:price).select { |b| if b.nil? then true else b < p[:price].to_i end }.count > 0
        @results.delete(bg)
      end
    end
    @results.each do |bg|
      temp_books = bg.books
      bg[:min_price] = temp_books.map(&:price).compact.min
      bg[:stock] = temp_books.where(:college_id => cookies[:college_id], :reserved => false).where(Book.arel_table[:admin_user_id].not_eq(nil)).count
    end
    @query = "Search results"
    respond_to do |format|
      format.js { render :template => "/books/filter.js.erb"}
    end
  end

  private
  def check_college
    if cookies[:college_id].nil? || cookies[:college_name].nil?
      flash[:warning] = "You need to choose your College!"
      redirect_to controller: 'application', action: 'check_cookies'
    end
  end
end
