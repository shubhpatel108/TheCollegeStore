ActiveAdmin.register BookGroup do

	index do 
    column :id
		column :title                     
    column :author
    column :publisher
    column :category
    default_actions                   
  end              

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
  	f.has_many :books, :new_record => false do |b|
      b.input :user
      b.input :college
      b.input :isbn
  		b.input :price
  		b.input :edition
  	end
	f.actions                         
  end
 # form :partial => "shared/sell_book_form", :locals => {:book_group => [:admin, @book_group], :books => :books}
end
