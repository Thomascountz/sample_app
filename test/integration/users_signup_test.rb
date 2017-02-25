require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test "invalid signup" do
    get signup_path
    assert_select 'form[action="/signup"]'
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { name: " ",
                                          email: "user@invalid",
                                          password: "foo",
                                          password_confirmation: "bar" } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explaination'
    assert_select 'div.field_with_errors'
  end
  
  test 'valid signup' do
    get signup_path
    assert_difference 'User.count', 1 do
      post signup_path, params: { user: { name: "John Doe",
                                          email: "johndoe@email.com",
                                          password: "foobar",
                                          password_confirmation: "foobar" } }
    end
    follow_redirect!
    # assert_template "users/show"
    assert_not flash.empty?
    
    # assert is_logged_in?
  end
end
