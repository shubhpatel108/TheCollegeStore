class CouponsController < ApplicationController
  before_filter :is_cart_empty

  def index
    @coupons = Coupon.all
    if session[:value_remaining].nil?
      session[:value_remaining] = session[:cart_total] || 0
    end
    @coupons.each do |c|
      c[:distributor] = c.distributor
    end
  end

  def add_coupon
    c_id = params[:id]
    @coupon = Coupon.where(:id => c_id).first
    @coupons = Coupon.all
    if not @coupon.nil?
        session[:value_remaining] -= @coupon.value
        session[:coupons] ||= []
        session[:coupons] << @coupon.id
        respond_to do |format|
          format.js
        end
    else
        render :js => "FlashNotice('error', 'No such coupon!');"
    end
  end

  def remove_coupon
    c_id = params[:id]
    @coupon = Coupon.where(:id => c_id).first
    @coupons = Coupon.all
    if not @coupon.nil?
      session[:value_remaining] += @coupon.value
      session[:coupons].delete_at(session[:coupons].index(@coupon.id) || session[:coupons].length)
      respond_to do |format|
        format.js
      end
    else
      render :js => "FlashNotice('error', 'No such Coupon');"
    end
  end
end
