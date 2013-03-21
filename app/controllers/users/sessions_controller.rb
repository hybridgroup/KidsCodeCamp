class Users::SessionsController < Devise::SessionsController
  def dashboard
  end
  def after_sign_in_path_for(resource)
    if current_user.is_admin.zero?
      posts_path
    else
      dashboard_path
    end
  end
end