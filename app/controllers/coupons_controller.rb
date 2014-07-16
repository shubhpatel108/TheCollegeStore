class CouponsController < ApplicationController

  def index
    @coupons = Coupon.all
    @coupons.each do |c|
      c[:distributor] = c.distributor
    end
  end

  def add_coupon
    c_id = params[:id]
    @coupon = Coupon.where(:id => c_id).first
    if not @coupon.nil?
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
    if not @coupon.nil?
      session[:coupons].delete(@coupon.id)
      respond_to do |format|
        format.js
      end
    else
      render :js => "FlashNotice('error', 'No such Coupon');"
    end
  end
end
