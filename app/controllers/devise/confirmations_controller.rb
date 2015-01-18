class Devise::ConfirmationsController < DeviseController
	
	# GET /resource/confirmation/new
  def new
    self.resource = resource_class.new
  end

  # POST /resource/confirmation
  def create
    self.resource = resource_class.send_confirmation_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      respond_with({}, location: after_resending_confirmation_instructions_path_for(resource_name))
    else
      respond_with(resource)
    end
  end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?

    if resource.errors.empty?
      set_flash_message(:notice, :confirmed) if is_flashing_format?
      respond_with_navigational(resource){ redirect_to after_confirmation_path_for(resource_name, resource) }
    else
      respond_with_navigational(resource.errors, status: :unprocessable_entity){ render :new }
    end
  end

  protected

  # The path used after resending confirmation instructions.
  def after_resending_confirmation_instructions_path_for(resource_name)
    is_navigational_format? ? new_session_path(resource_name) : '/'
  end

  # The path used after confirmation.
  def after_confirmation_path_for(resource_name, resource)
    recommendation = Recommendation.where(:recommended_id => resource.id).first
    if not recommendation.nil?
      recommender = recommendation.recommender
      recommender.points = 0 if recommender.points.nil?
      recommender.points += 300
      recommender.save

      reco_till_now = Recommendation.where(:recommender_id => recommender.id).count%10
      user_earning = Earning.where(:user_id => recommender.id).first
      if user_earning.nil?
        user_earning = Earning.new(:user_id => recommender.id, :paid => 0, :due => 0)
      end

      case reco_till_now
      when 3
        user_earning.due += 10
      when 6
        user_earning.due += 15
      when 0
        user_earning.due += 25
      end
      user_earning.save!
    end

    if signed_in?(resource_name)
      signed_in_root_path(resource)
    else
      new_session_path(resource_name)
    end
  end
end