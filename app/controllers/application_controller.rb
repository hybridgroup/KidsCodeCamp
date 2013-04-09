class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :firebug

  rescue_from CanCan::AccessDenied do |exception|
    if user_signed_in?
      redirect_to main_app.posts_path, :alert => exception.message
    else
      redirect_to main_app.login_path, :alert => 'You need to be logged in to post a message.'
    end
  end

  def admin?
    controller.class.name.split("::").first=="Admin"
  end
  
  private
  def fb(message, type = :debug)
    request.env['firebug.logs'] ||= []
    request.env['firebug.logs'] << [type.to_sym, message.to_s]
  end
end
