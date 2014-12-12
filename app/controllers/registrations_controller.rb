class RegistrationsController < Devise::RegistrationsController
  before_filter :check_college

  def new
  	@college_id = params[:college_id]
    super
  end

  def create
    super
    if resource.save and not session[:recommender_id].nil?
      recommender = User.where(:id => session[:recommender_id]).first
      if not recommender.nil?
        Recommendation.create(:recommender_id => recommender.id, :recommended_id => resource.id)
      end
    end
  end

  def update
    super
  end
  
  def update_mobile
    id = sanitize(params[:user_id])
    @user = User.find(id)
    mobile = sanitize(params[:mobile])
    @user.mobile = mobile
    @user.college_id = cookies[:college_id]
    @user.save!
    sign_in @user, :event => :authentication
    flash[:success] = "Successfully authenticated!"
    redirect_to :books
  end

  def recommend
    id = params[:recommended_by_id].to_i
    session[:recommender_id] = id
    redirect_to :controller => "registrations", :action=> "new"
  end

  def send_sms
    
  end

  private
  def check_college
    if cookies[:college_id].nil? || cookies[:college_name].nil?
      flash[:warning] = "You need to choose your College!"
      redirect_to controller: 'application', action: 'check_cookies'
    end
  end
end
