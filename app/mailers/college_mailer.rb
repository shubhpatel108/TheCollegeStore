class CollegeMailer < ActionMailer::Base

  def load_setting
    @@smtp_settings = {
      :address              => "smtp.zoho.com",
      :port                 => 465,
      :user_name            => "contact@thecollegestore.in",
      :password             => "saq1sazx",
      :authentication       => :login,
      :ssl                  => true,
      :tls                  => true,
      :enable_starttls_auto => true
    }
  end

  def request_admin_to_add_college(email,college_name)
    load_setting
  	@email = email
  	@college_name = college_name
    mail(from: "contact@thecollegestore.in", :to=>'shubhpatel108@gmail.com', :subject=>"Urgent::Add the college")
  end
end
