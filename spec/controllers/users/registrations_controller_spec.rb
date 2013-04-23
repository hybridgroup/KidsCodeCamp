require 'spec_helper'

describe Users::RegistrationsController do
  render_views
  let(:user){ create(:user) }
  let(:admin_user){ create(:user, admin: true) }
 
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end
 
  describe "POST #create" do
    context "user_signed_in?" do
      let(:create_user){ post :create, user: attributes_for(:user,:invalid) }

      before do
        set_user_session(user)
      end

      it "User.count doesn't change" do
        expect {
          create_user
        }.to_not change(User,:count)
      end

      it "redirect_to root_path" do
        create_user
        response.should redirect_to posts_path
      end
    end # user_signed_in?

    context "!user_signed_in?" do
      context "!@user.valid?" do
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
    end # !user_signed_in?
  end
 
  describe "PUT 'update'" do
    let(:update_user){ put :update, user: attributes_for(:user), id: user }
    let(:update_invalid_user){ put :update, user: attributes_for(:user, :invalid), id: user }

    before(:each) do
      set_user_session(user)
    end
 
    describe "!@user.valid?" do
      it "@user.email doesn't change" do
        update_invalid_user
        response.should render_template('edit')
      end

      it "render #edit" do
        update_invalid_user
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