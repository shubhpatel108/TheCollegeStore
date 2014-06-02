class CartController < ApplicationController
  def add_item
    book_id = params[:id]
    session[:cart] ||= []
    session[:cart] << book_id
    respond_to do |format|
      format.js
    end
  end
end
