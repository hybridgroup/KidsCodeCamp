class Users::SessionsController < Devise::SessionsController
  def dashboard
  end
  
  def after_sign_in_path_for(resource)
    if current_user.is_admin?
      rails_admin_path
    else
      posts_path
    end
  end

  def after_sign_out_path_for(resource)
    posts_path
  end
end