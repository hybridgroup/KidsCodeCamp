require 'spec_helper'

describe Users::RegistrationsController do
  let(:user){ double('User', is_admin: false) }
  let(:admin_user){ double('User', is_admin: true) }

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  [:new, :create, :cancel].each do |action|
    describe "GET #{action}" do
      context "when not user_signed_in?" do
        it "render ##{action}" do
          get action
          response.should render_template :new
        end
      end
    end
  end

  [:edit, :update, :destroy].each do |action|
    describe "GET #{action}" do
      context "when not user_signed_in?" do
        it "redirect_to login_path"
      end
    end
  end
end