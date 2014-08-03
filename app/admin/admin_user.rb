ActiveAdmin.register AdminUser do     
  index do 
    column :full_name                           
    column :email
    column :room
    column :mobile
    column :current_sign_in_at        
    column :last_sign_in_at           
    column :sign_in_count             
    default_actions                   
  end                                 

  filter :full_name
  filter :email
  filter :room
  filter :mobile          

  form do |f|                         
    f.inputs "Admin Details" do  
      f.input :full_name     
      f.input :email                  
      f.input :password               
      f.input :password_confirmation
      f.input :room
      f.input :mobile
    end                               
    f.actions                         
  end                                 
end                                   
