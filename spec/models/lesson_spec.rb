require 'spec_helper'

describe Lesson do

  context "model fields" do
		it "is invalid without a title" do
		  FactoryGirl.build(:lesson, title: nil).should_not be_valid
		end
		it "is invalid without a description" do
		  FactoryGirl.build(:lesson, description: nil).should_not be_valid
		end
  end
end