require 'test_helper'

class UserControllerTest < ActionController::TestCase
  test "should get register" do
    get :register
    assert_response :success
  end

  test "should get renew" do
    get :renew
    assert_response :success
  end

  test "should get account" do
    get :account
    assert_response :success
  end

  test "should get recovery" do
    get :recovery
    assert_response :success
  end

end
