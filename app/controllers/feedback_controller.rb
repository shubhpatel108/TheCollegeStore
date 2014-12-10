class FeedbackController < ApplicationController

  def new
    @feedback = Feedback.new(page: request.referer)
  end

  def create
    @feedback = Feedback.new(params[:feedback])
    if @feedback.valid?
      FeedbackMailer.feedback(@feedback).deliver
      flash[:success] = "Thank you for your feedback !"
      redirect_to :back      
    else
      @error_message = "Please enter your #{@feedback.subject.to_s.downcase}"
      render :action => 'new', :status => :unprocessable_entity
    end
  end
end