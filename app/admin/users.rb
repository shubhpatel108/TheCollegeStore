ActiveAdmin.register User do

  index do 
    column :first_name
    column :last_name
    column :college
    column :mobile                           
    column :email                                
    column :sign_in_count
    column :points
    column :da_roll
    default_actions                   
  end

  filter :first_name
  filter :last_name
  filter :college
  filter :mobile
  filter :email
  filter :points
  filter :da_roll

  form do |f|                         
    f.inputs "User Details" do 
      f.input :first_name
      f.input :last_name
      f.input :college
      f.input :mobile
      f.input :da_roll
      f.input :email
      f.input :password               
    end                               
    f.actions                         
  end     
end
