ActiveAdmin.register Wishlist do

	index do
		column :wisher
		column :wish
		default_actions
	end

	filter :wisher_first_name, as: :string
	filter :wish

	form do |f|
		f.inputs "Wishlist Details" do
			f.input :wisher, as: :select, collection: User.all.map{ |h| ["#{h.first_name} #{h.last_name}", h.id] }
			f.input :wish
		end
		f.actions
	end
end
