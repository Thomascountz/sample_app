require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:thomas)
  end
  
  test "invalid update" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    
    patch user_path(@user), params: { user: { name: " ",
                                          email: "user@invalid",
                                          password: "foo",
                                          password_confirmation: "bar" } }
    assert_template 'users/edit'
    assert_select 'div#error_explaination'
    assert_select 'div.field_with_errors'    
  end
  
  test "valid update" do
    get edit_user_path(@user)
    assert_template "users/edit"
    
    name = "King Henry"
    email = "yourking@valid.com"
    patch user_path(@user), params: { user: { name: name,
                                          email: email,
                                          password: "",
                                          password_confirmation: "" } }
    
    assert_redirected_to @user                                      
    assert_not flash.empty? 
    
    @user.reload
    
    assert_equal(name, @user.name)
    assert_equal(email, @user.email)
  end
end
