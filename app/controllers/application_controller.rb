class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :firebug

  def after_sign_in_path_for(resource)
    dashboard_admin_users_path
  end

  def admin?
    controller.class.name.split("::").first=="Admin"
  end

  def user_layout
    ['new', 'edit'].include?(action_name) && current_user.is_admin.zero? ? 'application' : 'admin'
  end
  
  private
  def fb(message, type = :debug)
    request.env['firebug.logs'] ||= []
    request.env['firebug.logs'] << [type.to_sym, message.to_s]
  end
end
