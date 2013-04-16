require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test "Title is required" do
    post = Post.new
    assert !post.save
  end
  test "Test with error" do
    assert undefined_var
  end
end
