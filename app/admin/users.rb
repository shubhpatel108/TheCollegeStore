ActiveAdmin.register User do

  index do 
    column :first_name
    column :last_name
    column :mobile                           
    column :email                                
    column :sign_in_count             
    default_actions                   
  end

  filter :first_name

  form do |f|                         
    f.inputs "User Details" do 
      f.input :first_name
      f.input :last_name
      f.input :college
      f.input :mobile   
      f.input :email                  
      f.input :password               
      f.input :password_confirmation  
    end                               
    f.actions                         
  end     
end
