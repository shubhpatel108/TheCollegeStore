require 'test_helper'

class EmailapiControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get subscribe" do
    get :subscribe
    assert_response :success
  end

end
