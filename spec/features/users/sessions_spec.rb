require "spec_helper"

describe "user sessions", type: :feature do
  describe "login" do
    context "with valid credentials" do
      context "for admin users" do
        it "allows users to sign in after they have registered" do
          user = create(:user, is_admin: true)

          sign_in(user)
          
          page.should have_content("Site administration")
        end
      end


      context "for editor users" do
        it "allows users to sign in after they have registered" do
          user = create(:user, is_admin: false)

          sign_in(user)

          page.should have_content("Community")
          page.should have_content("Signed in successfully")
        end
      end
    end
    
    context "with invalid credentials" do
      it "denies login" do
        user = create(:user)
        user.email = ''

        sign_in(user)

        page.should have_content("Invalid email or password")
      end
    end
  end

  describe 'logout' do
    it 'destroys the session' do
      sign_in
      sign_out
      page.should have_content("Signed out successfully")
    end
  end
end