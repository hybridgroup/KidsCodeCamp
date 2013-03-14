class Users::SessionsController < Devise::SessionsController
  before_filter :require_no_authentication

  def dashboard
  end
end