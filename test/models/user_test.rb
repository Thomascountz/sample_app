require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'John Doe', email: 'johndoe@example.com')
  end
  
  test "should be valid" do
    assert @user.valid?
  end
  
  test "should be invalid without a name" do
    @user.name = nil
    assert_not @user.valid?
  end
  
  test "should be invalid without an email" do
    @user.email = nil
    assert_not @user.valid?
  end
  
  test "should be invalid with a name longer than 50 characters" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end
  
  test "should be invalid with an email longer than 255 characters" do
    @user.name = "a" * 246 + "@gmail.com"
    assert_not @user.valid?
  end
end
