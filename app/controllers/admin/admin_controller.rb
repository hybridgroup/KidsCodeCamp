class Admin::AdminController < ApplicationController
  layout "admin"
  before_filter :authenticate_user!
  load_and_authorize_resource

  def current_ability
    @current_ability ||= AdminAbility.new(current_user)
  end

  rescue_from CanCan::AccessDenied do |exception|
      redirect_to posts_path, :notice => exception.message
  end 
end