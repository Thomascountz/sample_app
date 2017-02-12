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
  
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com, user@user..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
end
