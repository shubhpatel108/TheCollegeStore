ActiveAdmin.register CollegeBook do

	index do
		column :college_id
		column :book_group_id
		default_actions
	end

	filter :college_id
	filter :book_group_id

	form do |f|
		f.inputs "College Book details" do
			f.input :book_group_id
			f.input :college_id, as: :select, collection: College.all.map{ |h| ["#{h.name}", h.id] }
			f.actions
		end
	end

end
