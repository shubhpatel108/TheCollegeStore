class RegistrationsController < Devise::RegistrationsController
  before_filter :check_college
  def new
  	@college_id = params[:college_id]
    super
  end

  def create
    params[:user][:mobile] = session[:mobile]
    if params[:user][:verification_code] != session[:verification_code]
      flash[:error] = "Verification Failed. Please try again."
      redirect_to :root
    else
      params[:user].delete :verification_code
      super
      if resource.save and not session[:recommender_id].nil?
        recommender = User.where(:id => session[:recommender_id]).first
        if not recommender.nil?
          Recommendation.create(:recommender_id => recommender.id, :recommended_id => resource.id)
        end
      end
    end
  end

  def update
    super
  end
  
  def update_mobile
    id = sanitize(params[:user_id])
    @user = User.find(id)
    mobile = session[:mobile]
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

  def send_verification_sms
    mobile = params[:mobile]
    #send_sms and store verification code in session[:verification_code]
    #session[:verification_code] = Random.new.rand(1000..10000-1).to_s
    code = 1111
    session[:verification_code] = code.to_s
    #url = URI.parse("http://sms.ssdindia.com/api/sendhttp.php?authkey=5863AO8VuQyUREU54882154&mobiles=#{mobile}&message=Hi%2C%20please%20enter%20the%20code%20#{session[:verification_code]}%20wherever%20prompted%20to%20successfully%20register%20on%20TheCollegeStore.in.%20-TheCollegeStore.in&sender=clgstr&route=4")
    #req = Net::HTTP::Get.new(url.to_s)
    #res = Net::HTTP::start(url.host, url.port) {|http|
    #  http.request(req)
    #}

    session[:mobile] = mobile
    render :js => "document.getElementById('#{params[:button]}').setAttribute('type', 'submit');"
  end

  private
  def check_college
    if cookies[:college_id].nil? || cookies[:college_name].nil?
      flash[:warning] = "You need to choose your College!"
      redirect_to controller: 'application', action: 'check_cookies'
    end
  end
end
