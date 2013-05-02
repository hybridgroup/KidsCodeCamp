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

  describe "POST #create" do
    context "user_signed_in?" do
      before :each do
        sign_in user
      end

      it "redirect_to posts_path" do
        post :create, user: { email: user.email, password: user.password }
        response.should redirect_to posts_path
        flash[:alert].should include "You are already signed in."
      end
    end

    context "!user_signed_in?" do
      context "!@user.email.valid?" do
        it "render #new" do
          post :create, user: { email: '', password: user.password }
          response.should render_template :new
        end
      end
   
      context "@user.email.valid?" do
        context "@user.is_admin?" do
          it "redirect_to rails_admin_path" do
            post :create, user: { email: admin_user.email, password: admin_user.password }
            response.should redirect_to rails_admin_path
          end
        end

        context "!@user.is_admin?" do
          it "redirect_to posts_path" do
            post :create, user: { email: user.email, password: user.password }
            response.should redirect_to posts_path
          end
        end
      end
    end # !user_signed_in?
  end

  describe "DELETE #destroy" do
    context "user_signed_in?" do

      context "current_user.is_admin?" do
        before :each do
          sign_in admin_user
        end

        it "current_user.blank?" do
          expect { sign_out admin_user }.to change{ controller.current_user }.from(admin_user).to(nil)
        end
      end

      context "!current_user.is_admin?" do
        before :each do
          sign_in user
        end

        it "current_user.blank?" do
          expect { sign_out admin_user }.to change{ controller.current_user }.from(user).to(nil)
        end
      end
    end
  end
end