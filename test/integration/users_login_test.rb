require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  test 'login with invalid parameters' do
    get login_path
    
    assert_template 'sessions/new'
    assert_select 'form[action="/login"]'
    
    post login_path params: { session: { email: " ", password: " " } }
    
    assert_template 'sessions/new'
    assert_select 'form[action="/login"]'
    
    assert_not flash.empty?
    
    get root_path
    
    assert flash.empty?
  end
end
