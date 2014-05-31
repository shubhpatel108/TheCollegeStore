class EmailapiController < ApplicationController
  def index
  end

  def subscribe
  	@list_id = "5a3a73aa4c"
   	mailchimp = Gibbon::API.new

    mailchimp.lists.subscribe({
      :id => @list_id,
      :email => {:email => params[:email][:address]}
    })
    redirect_to :root
  end
end
