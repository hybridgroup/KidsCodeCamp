require "spec_helper"

describe "user registrations" do
  context "with valid data" do
    it "allows new users to register with an email address, password and username" do
      visit sign_up_path

      fill_in "Username",              :with => "noob@example.com"
      fill_in "Email",                 :with => "noob@example.com"
      fill_in "Password",              :with => "never_gone_give_you_up"
      fill_in "Password confirmation", :with => "never_gone_give_you_up"

      click_button "Sign up"
      page.find('.flash_message').should have_content("Welcome! You have signed up successfully.")
    end
  end
  

  context "with invalid data" do
    it "disallow new users to register" do
      visit sign_up_path

      fill_in "Username",              :with => ""
      fill_in "Email",                 :with => "noob@example.com"
      fill_in "Password",              :with => "never_gone_give_you_up"
      fill_in "Password confirmation", :with => "never_gone_give_you_up"

      click_button "Sign up"

      page.find('#error_explanation').should have_content("prohibited this user from being saved")
    end
  end
end

describe "user sessions" do
  describe "with valid credentials" do
    describe "for admin users" do
      it "allows users to sign in after they have registered" do
        user = FactoryGirl.create(:admin_user)

        visit login_path

        fill_in "Email",    :with => user.email
        fill_in "Password", :with => user.password

        click_button "Sign in"

        page.find('h1').should have_content("Site administration")
      end
    end


    describe "for editor users" do
      it "allows users to sign in after they have registered" do
        user = FactoryGirl.create(:user)

        visit login_path

        fill_in "Email",    :with => user.email
        fill_in "Password", :with => user.password

        click_button "Sign in"

        page.find('.flash_message').should have_content("Signed in successfully")
      end
    end
  end
  
  describe "with invalid credentials" do
    it "denies login" do
      user = FactoryGirl.create(:user)

      visit login_path

      fill_in "Email",    :with => ''
      fill_in "Password", :with => user.password

      click_button "Sign in"

      page.find('.flash_message').should have_content("Invalid email or password")
    end
  end
end