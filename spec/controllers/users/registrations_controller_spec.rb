require 'spec_helper'

describe Users::RegistrationsController do
  render_views
 
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end
 
  describe "POST #create" do
    context "user_signed_in?" do
     it "redirect_to root_path" do
      create_user
      response.should redirect_to posts_path
    end
   end
    context "!user_signed_in?" do
      context "@user.invalid?" do
        let(:create_user){ post :create, user: attributes_for(:user,:invalid) }
   
        it "!@user.save" do
          expect {
            create_user
          }.to_not change(User, :count)
        end
   
        it "render #new" do
          create_user
          response.should render_template('new')
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
    end # user_signed_in?
  end
 
  describe "PUT 'update'" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
      sign_in @user
    end
 
    describe "Failure" do
      before(:each) do
        # The following information is valid except for display_name which is too long (max 20 characters)
        @attr = { :email => @user.email, :display_name => ("t" * 35), :current_password => @user.password }
      end
 
      it "should render the 'edit' page" do
        put :update, :id => subject.current_user, :user => @attr
 
        # HAVE PUT THE DEBUGS THAT I'D LIKE TO GET WORKING FIRST
        # Would like to be able to debug and check I'm getting the error(s) I'm expecting
        #puts subject.current_user.errors.messages # doesn't show me the errors
        # Would like to be able to debug what html is being returned:
        #puts page.html # only return the first line of html
 
        # Would like to be able to determine that this test is failing for the right reasons
        response.body.should include "Display name is too long (maximum is 30 characters)"
        assigns[:user].errors[:display_name].should include "is too long (maximum is 30 characters)"
        response.should render_template('edit')
      end
    end
 
    describe "Success" do
      it "should change the user's display name" do
        @attr = { :email => @user.email, :display_name => "Test", :current_password => @user.password }
        put :update, :id => subject.current_user, :user => @attr
        subject.current_user.reload
        response.should redirect_to(root_path)
        subject.current_user.display_name == @attr[:display_name]
      end
    end
  end
 
  describe "authentication of edit/update pages" do
    describe "for non-signed-in users" do
      before(:each) do
        @user = FactoryGirl.create(:user)
      end
 
      describe "for non-signed-in users" do
        it "should deny access to 'edit'" do
          get :edit, :id => @user
          response.should redirect_to(new_user_session_path)
        end
 
        it "should deny access to 'update'" do
          put :update, :id => @user, :user => {}
          response.should redirect_to(new_user_session_path)
        end
      end
    end
  end
end