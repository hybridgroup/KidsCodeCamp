require 'spec_helper'

describe "Posts" do
  describe "GET /posts" do
    it "list all posts" do
      visit posts_path
      page.should have_content('Community')
    end
  end
end
