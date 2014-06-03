class CollegeMailer < ActionMailer::Base
  default from: "xyz@gmail.com"

  def request_admin_to_add_college(email,college_name)
  	@email = email
  	@college_name = college_name
  	mail(:to=>'abc@gmail.com',:subject=>"Urgent::Add the college")
  end
end
