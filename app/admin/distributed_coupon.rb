ActiveAdmin.register DistributedCoupon do

	filter :user_id, as: :select, collection: User.all.map{ |h| ["#{h.first_name} #{h.last_name}", h.id] }
	filter :coupon_id, as: :select, collection: Coupon.all.map { |e| ["#{e.distributor.name}", e.id]}
	filter :code
	filter :by_guest

	form do |f|
		f.inputs "Distributed Coupons" do 
			f.input :user_id, as: :select, collection: User.all.map { |h| ["#{h.first_name} #{h.last_name}", h.id] }
			f.input :coupon_id, as: :select, collection: Coupon.all.map { |e| ["#{e.distributor.name}", e.id]}
			f.input :code
			f.input :by_guest
		end
		f.actions
	end
end
