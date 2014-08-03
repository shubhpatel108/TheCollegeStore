ActiveAdmin.register BooksByUser do

	filter :book_id, as: :select, collection: Book.all.map { |e| ["#{e.book_group.title}",  e.id]  }
	filter :user_id, as: :select, collection: User.all.map{ |h| ["#{h.first_name} #{h.last_name}", h.id] }


	index do 
		column "Book" do |m|
			b = Book.where(:id => m.book_id).first
		  b_g = BookGroup.where(:id => b.book_group_id).first
		  link_to b_g.title, admin_book_group_path(b.book_group_id)
		end
		column "User" do |m|
			u = User.where(:id => m.user_id).first
		  link_to "#{u.first_name} #{u.last_name}", admin_user_path(u.id)
		end
		default_actions
	end

	form do |f|
		f.inputs "Books By User" do
			f.input :book_id, as: :select, collection: Book.all.map { |e| ["#{e.book_group.title}",  e.id]  }
			f.input :user_id, as: :select, collection: User.all.map{ |h| ["#{h.first_name} #{h.last_name}", h.id] }
		end
		f.actions
	end
end
