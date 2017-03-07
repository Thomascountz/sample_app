require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:thomas)
    @micropost = Micropost.new(content: "Lorem ipsum", user_id: @user.id)
  end
  
  test "should be valid" do
    assert @micropost.valid?
  end
  
  test "should not be valid" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end
end
