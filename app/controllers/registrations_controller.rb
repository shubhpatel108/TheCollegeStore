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
end