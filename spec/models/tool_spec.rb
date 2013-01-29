require 'spec_helper'

describe Tool do

  context "model fields" do
		it "is invalid without a name" do
		  FactoryGirl.build(:tool, name: nil).should_not be_valid
		end
  end
end