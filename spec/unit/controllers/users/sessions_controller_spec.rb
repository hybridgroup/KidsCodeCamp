require 'spec_helper'

describe Users::SessionsController do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  let(:user){ create(:user) }
  let(:admin_user){ create(:user, is_admin: true) }

  describe "GET #new" do
    context "user_signed_in?" do
      before :each do
        sign_in user
      end

      it "redirect_to posts_path" do
        get :new
        response.should redirect_to posts_path
        flash[:alert].should include "You are already signed in."
      end
    end

    context "!user_signed_in?" do
      it "render #new" do
        get :new
        response.should render_template :new
      end
    end
  end
end