class Users::SessionsController < Devise::SessionsController
  def dashboard
  end
  
  def after_sign_in_path_for(resource)
    if current_user.is_admin.zero?
      posts_path
    else
      rails_admin_path
    end
  end

  def after_sign_out_path_for(resource)
    request.referrer
  end
end