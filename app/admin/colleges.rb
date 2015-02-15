ActiveAdmin.register College do

	index do
		column :id
		column :name
		column :city
		default_actions
	end

	filter :name
	filter :city

	# form do |f|
	# 	f.inputs "City Details" do
	# 		f.input :name
	# 		f.input :city, as: :select, collection: College.all.map{ |h| ["#{h.city}", "#{h.city}"] }
	# 		f.actions
	# 	end
	# end
end
