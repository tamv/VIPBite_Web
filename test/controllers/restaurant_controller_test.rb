require 'test_helper'

class RestaurantControllerTest < ActionController::TestCase
  test "should get search" do
    get :search
    assert_response :success
  end

  test "should get detail" do
    get :detail
    assert_response :success
  end

end
