require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:thomas)
    @micropost = @user.microposts.build(content: "Lorem ipsum")
  end
  
  test "should be valid" do
    assert @micropost.valid?
  end
  
  test "should not be valid without a user_id" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end
  
  test "should not be valid without content" do
    @micropost.content = "     "
    assert_not @micropost.valid?
  end
  
  test "should not be valid with content longer than 140 characters" do
    @micropost.content = "a" * 141
    assert_not @micropost.valid?
  end
  
  test "order should be most recent first" do
    assert_equal micropost(:most_recent), Micropost.first
  end
end
