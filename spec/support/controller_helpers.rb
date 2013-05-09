module ControllerHelpers
  def sign_in(user = mock_model('User', is_admin?: false, id: 1))
    if user.nil?
      request.env['warden'].stub(:authenticate!).
        and_throw(:warden, {:scope => :user})
      controller.stub :current_user => nil
    else
      request.env['warden'].stub :authenticate! => user
      controller.stub :current_user => user
    end
  end
end