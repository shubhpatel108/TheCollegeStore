class RegistrationsController < Devise::RegistrationsController
  def new
  	@college_id = params[:college_id]
    super
  end

  def create
    super
    
  end

  def update
    super
  end
  
  def update_mobile
    id = params[:user_id]
    @user = User.find(id)
    mobile = params[:mobile]
    @user.mobile = mobile
    @user.college_id = cookies[:college_id]
    @user.save!
    sign_in @user, :event => :authentication
    flash[:success] = "Successfully authenticated!"
    redirect_to :books
  end
end
