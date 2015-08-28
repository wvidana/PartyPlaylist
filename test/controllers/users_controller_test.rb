require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get spotify" do
    get :spotify
    assert_response :success
  end

end
