ActiveAdmin.register Book do
	
	scope :unsold

	index do 
		column :id
		column :book_group
		column :edition
		column :isbn
		column :price
		column :user
		column :sold
		column :reserved
		default_actions
	end

	form do |f|                         
    f.inputs "User Details" do
		f.input :user
		f.input :book_group
		f.input :college
		f.input :edition
		f.input :isbn
		f.input :price               
		f.input :sold
		f.input :reserved  
    end                               
    f.actions                         
  end     
end
