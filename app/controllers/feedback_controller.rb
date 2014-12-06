class FeedbackController < ApplicationController

  def new
    
  end

  def create
    @feedback = params[:feedback]
    if @feedback[:comment] && !@feedback[:comment].strip.blank?
      FeedbackMailer.feedback(@feedback).deliver
      flash[:success] = "Thank you for your feedback !"
      redirect_to :back
    else
      @error_message = "Please enter your #{@feedback.subject.to_s.downcase}"

      render :action => 'new', :status => :unprocessable_entity
    end
  end

end
