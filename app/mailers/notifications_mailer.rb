class NotificationsMailer < ActionMailer::Base
  default :from => "ashleygwysocki@gmail.com"
  default :to => "ashley@hybridgroup.com"

  def new_message(message)
    @message = message
  end

end
