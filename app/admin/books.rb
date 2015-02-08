ActiveAdmin.register Book do
	
	scope :unsold

	index do 
		column :id
		column :book_group
		column :edition
		column :isbn
		column :price
		column "User" do |m|
			u = User.where(:id => m.user_id).first
		  link_to "#{u.first_name} #{u.last_name}", admin_user_path(u.id)
		end
		column :sold
		column :reserved
    column "Buyer" do |n|
      b = User.where(:id => n.buyer_id).first
      link_to "#{b.first_name} #{b.last_name}", admin_user_path(b.id) unless b.nil?
    end
    default_actions
	end

	filter :id
	filter :book_group_title, as: :string
	filter :book_group_author, as: :string
	filter :edition
	filter :isbn
	filter :price
	filter :college
	filter :user_first_name, as: :string
	filter :user_last_name, as: :string
	filter :buyer_first_name, as: :string
	filter :buyer_last_name, as: :string
	filter :city_vendor_vendor_name, as: :string
	filter :admin_user
	filter :sold
	filter :reserved
	filter :by_guest
	filter :created_at, as: :date_range

	form do |f|                         
    f.inputs "User Details" do
		f.input :user, as: :select, collection: User.all.map{ |h| ["#{h.first_name} #{h.last_name}", h.id] }
		f.input :book_group
		f.input :college
		f.input :edition
		f.input :isbn
		f.input :price
		f.input :buyer, as: :select, collection: User.all.map{ |h| ["#{h.first_name} #{h.last_name}", h.id] }
		f.input :admin_user
		f.input :by_guest
		f.input :sold
		f.input :reserved
    end                               
    f.actions                         
  end     
end
