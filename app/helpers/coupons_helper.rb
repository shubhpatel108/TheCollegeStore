module CouponsHelper
	def distribute_coupon
        @coupons = Coupon.where(:id => session[:coupons])
        @coupons.each do |c|
          if not c.out_of_stock
            d_coupon = DistributedCoupon.new(:coupon_id => c.id)
            d_coupon.user_id = current_user.id
            d_coupon.code = c.generate_code(d_coupon.user_id, d_coupon.by_guest)
            d_coupon.save!
            c[:dist_code] = d_coupon.code
            c.stock -= 1;
            c.save
            c[:err] = false
          else
            c[:err] = true
          end
        end
        session[:coupons] = []

        #notify user about the coupons and Book added
        BookMailer.seller_coupons(current_user, @new_book, @coupons).deliver
	end
end