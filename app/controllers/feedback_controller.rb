class FeedbackController < ApplicationController

  def new
    @feedback = Feedback.new(page: request.referer)
  end

  def create
    @feedback = Feedback.new(params[:feedback])
    if @feedback.valid?
      FeedbackMailer.feedback(@feedback).deliver
      flash[:success] = "Thank you for your feedback !"
      if request.original_url.include?(feedback_path)
        redirect_to :root
      else
        redirect_to :back
      end
    else
      @error_message = "Please enter your #{@feedback.subject.to_s.downcase}"
      render :action => 'new', :status => :unprocessable_entity
    end
  end
end