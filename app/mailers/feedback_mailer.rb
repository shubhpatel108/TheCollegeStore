class FeedbackMailer < ActionMailer::Base
  default :from => 'contact@thecollegestore.in'

  def feedback(feedback)
    @feedback = feedback
    mail(:to => 'rani.vhd@gmail.com', :subject => '[Feedback for YourSite]')
  end

end
