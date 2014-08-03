ActiveAdmin.register BookGroup do

	index do 
    column :id
		column :title
    column :author
    column :publisher
    column :category
    default_actions     
  end              

  filter :title
  filter :author
  filter :publisher
  filter :category
  filter :created_at

  form do |f|                         
    f.inputs "BookGroup Details" do       
      f.input :title                  
      f.input :author               
      f.input :publisher
      f.input :category
    end
    f.inputs "Image" do                               
      f.file_field :image
  	end
  	f.has_many :books, :new_record => true do |b|
      b.input :user, as: :select, collection: User.all.map{ |h| ["#{h.first_name} #{h.last_name}", h.id] }
      b.input :college
      b.input :isbn
  		b.input :price
  		b.input :edition
  	end
	f.actions                         
  end
 # form :partial => "shared/sell_book_form", :locals => {:book_group => [:admin, @book_group], :books => :books}
end
