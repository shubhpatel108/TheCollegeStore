class BooksController < ApplicationController

  def index
    @books = Book.all

    respond_to do |format|
      format.html
      format.json { render json: @thoughts }
    end
  end

  def search
  	@query = params[:query]
  	@results = current_user.goodreads_search(@query)
  end

end
