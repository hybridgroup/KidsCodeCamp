require 'spec_helper'

describe Users::RegistrationsController do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  let(:user){ create(:user) }
  let(:admin_user){ create(:user, admin: true) }
 
  describe "GET #new" do
    context "user_signed_in?" do
      before :each do
        sign_in(user)
      end

      it "redirect_to posts_path" do
        get :new
        response.should redirect_to posts_path
      end
    end

    context "!user_signed_in?" do
      it "render #new" do
        get :new
        response.should render_template :new
      end
    end
  end

  describe "POST #create" do
    context "user_signed_in?" do
      let(:create_user){ post :create, user: attributes_for(:user) }
      before :each do
        set_user_session(user)
      end

      it "redirect_to root_path" do
        create_user
        response.should redirect_to posts_path
      end
    end # user_signed_in?

    context "!user_signed_in?" do
      context "!@user.valid?" do
        let(:create_invalid_user){ post :create, user: attributes_for(:user,:invalid) }
   
        it "!@user.save" do
          expect {
            create_invalid_user
          }.to_not change(User, :count)
        end
   
        it "render #new" do
          create_invalid_user
          response.should render_template :new
        end
      end
   
      context "@user.valid?" do
        let(:create_user){ post :create, user: attributes_for(:user) }
   
        it "User.count +1" do
          expect {
            create_user
          }.to change(User, :count).by(1)
        end

        it "redirect_to posts_path" do
          create_user
          response.should redirect_to posts_path
        end
      end
    end # !user_signed_in?
  end
end