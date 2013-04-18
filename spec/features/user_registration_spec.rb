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
      within ".flash_message" do
        page.should have_content("Welcome! You have signed up successfully.")
      end
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

      within "#error_explanation" do
        page.should have_content("prohibited this user from being saved")
      end
    end
  end
end

describe "user sessions" do
  it "allows users to sign in after they have registered" do
    user = FactoryGirl.create(:user)

    visit login_path

    fill_in "Email",    :with => user.email
    fill_in "Password", :with => user.password

    click_button "Sign in"

    within ".flash_message" do
      page.should have_content("Signed in successfully")
    end
  end
end