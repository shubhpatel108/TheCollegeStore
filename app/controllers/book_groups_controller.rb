class BookGroupsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create]
  include CouponsHelper
  
  def new
  	@book_group = BookGroup.new
    @book_group.books.build
  end

  def create
    @book_group = BookGroup.new(sanitize_hash(params[:book_group]))
    @old_book_group = BookGroup.where(title: @book_group.title, author: @book_group.author, publisher: @book_group.publisher).first
    if not @old_book_group.nil?
      @new_book = Book.new(params[:book_group][:books_attributes]['0'])
      if not session[:city_vendor_id].nil?
        @new_book.user_id = session[:city_vendor_id]
        @new_book.save
      else
        @new_book.user_id = current_user.id
        @new_book.college_id = current_user.college_id
        @new_book.save
      end
      @old_book_group.books << @new_book
      @old_book_group.save

      distribute_coupon #func in coupon_helper.rb

      #BookMailer.notify_wishers(@old_book_group)
      # if current_user.daiictian?
      #   ContactUsMailer.book_added_notifier(@new_book, @new_book.book_group, @new_book.user).deliver
      # end
      @book_group = @old_book_group
      respond_to do |format|
        format.js { render :template => "/book_groups/final_step"}
      end
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

        distribute_coupon #func in coupon_helper.rb

        respond_to do |format|
          format.js { render :template => "/book_groups/final_step"}
        end
      else
        flash[:error] = "Something went wrong! Please try again"
        render :action => 'new'
      end
    end
  end

  def details
    @reserved_count = 0
    @book_group = BookGroup.where(:id => sanitize(params[:id])).first
    if @book_group.nil?
      render file: 'public/404', status: 404, formats: [:html]
    else
      @book_cat = @book_group.category
      @book_category = @book_cat.name
      @books = @book_group.books.where(:college_id => cookies[:college_id]).order(:reserved, :created_at).to_a
      @owners = []
      @flipkart_links = []
      @books.each do |b|
        if not b.isbn.nil?
          if not @flipkart_links.any? {|h| h[:isbn] == b.isbn} and not b.isbn.empty?
            @flipkart_links << {:isbn => b.isbn, :edition => b.edition}
          end
        end
        @owners << b.user
        if b.reserved
          @reserved_count += 1
        end
      end
      if not @flipkart_links.empty?
        temp_link = @flipkart_links.find { |h| h[:edition] == (@flipkart_links.map {|x| x[:edition]}.compact.max) }
        @flipkart_links.clear
        @flipkart_links << temp_link
      end
      @isbn_amazon = @flipkart_links.first[:isbn] unless @flipkart_links.empty?
      @wished = false
      if user_signed_in?
        w = Wishlist.where(:book_group_id => @book_group.id, :user_id => current_user.id).first
        if not w.nil?
          @wished = true
        end
      end
      @details = @books.zip(@owners)

      #suggestions
      @suggested_books = BookGroup.where(:category_id => @book_cat.id).to_a
      @suggested_books.delete(@book_group)
      @suggested_books = @suggested_books.sort_by {|b| b.college_stock(cookies[:college_id])}.reverse.slice(0..1)
    end
  end

  def category_books
    @c_id = sanitize(params[:id])
    @category = Category.where(:id => @c_id).first
    @books = BookGroup.where(:category_id => @c_id)
    college_id = cookies[:college_id]
    @books.each do |group|
        group[:stock] = group.books.where(:college_id => college_id, :reserved => false).count
        group[:min_price] = group.books.map(&:price).compact.min
    end
    respond_to do |format|
      format.js
    end
  end

  def all_categories
    @categories = Category.all
    respond_to do |format|
      format.js
    end
  end

  def incentive_for_new_book
    @coupons = Coupon.all
    price = params[:price].to_i
    session[:value_remaining] = price
    session[:coupons] = []
    respond_to do |format|
      format.js
    end
  end

  def lowest_price
    book_group = BookGroup.where(:title => params[:title], :author => params[:author], :publisher => params[:publisher]).first
    if book_group.nil?
      render :js => "document.getElementById('lowest_price').innerHTML = 'You are the first one to sell this book.';"
    else
      render :js => "document.getElementById('lp_no').innerHTML = " + book_group.books.map(&:price).min.to_s
    end
  end
end
