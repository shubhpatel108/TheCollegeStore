ActiveAdmin.register Book do
	
	scope :unsold

	index do 
		column :id
		column :book_group
		column :edition
		column :isbn
		column :price
		column :sold
		column :reserved
		default_actions
	end
end
