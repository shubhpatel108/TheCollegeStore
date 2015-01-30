ActiveAdmin.register Blogbook do     
  index do
    column :book_group_id
    column "BookGroup Name" do |m|
      bg = BookGroup.where(:id => m.book_group_id).first
      link_to "#{bg.title}", book_group_path(bg.id)
    end
    column :url, as: :text
    default_actions
  end

  filter :book_group_id
  filter :book_group_title, as: :string
  filter :url

  form do |f|       
    f.inputs "BlogBooks Details" do  
      f.input :book_group_id
      f.input :url, as: :text
    end
    f.actions
  end
end
