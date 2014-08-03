ActiveAdmin.register College do

	index do
		column :id
		column :name
		column :city
		default_actions
	end

	filter :name
	filter :city
end
