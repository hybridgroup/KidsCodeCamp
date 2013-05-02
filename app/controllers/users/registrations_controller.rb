class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_filter :require_no_authentication, :only => [ :new, :create, :cancel ]
  prepend_before_filter :authenticate_scope!, :only => [:edit, :update, :destroy]

  def after_sign_up_path_for(resource)
    posts_path
  end
  
  def after_sign_in_path_for(resource)
    posts_path
  end
end