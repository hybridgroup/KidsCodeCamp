require 'spec_helper'

describe Users::RegistrationsController, type: :controller do
  let(:user){ mock_model('User', is_admin?: false) }
  let(:admin_user){ mock_model('User', is_admin?: true) }

  describe "#after_sign_up_path_for" do
    context "resource.is_admin?" do
      it "redirects to posts_path" do
        controller.after_sign_up_path_for(admin_user).should eq(posts_path)
      end
    end

    context "!resource.is_admin?" do
      it "redirects to posts_path" do
        controller.after_sign_up_path_for(user).should eq(posts_path)
      end
    end
  end
end