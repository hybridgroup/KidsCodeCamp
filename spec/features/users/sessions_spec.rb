require "spec_helper"

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