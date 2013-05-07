module LoginMacros
  def set_user_session(user = create(:user))
    session[:user_id] = controller.stub(:current_user) { user }
  end

  def sign_in(user = create(:user))
    visit posts_path
    click_link 'Log in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
  end
  
  def sign_out
    visit posts_path
    click_link 'Logout'
  end
end