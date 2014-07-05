require 'test_helper'

class OurControllerTest < ActionController::TestCase
  test "should get our_team" do
    get :our_team
    assert_response :success
  end

end
