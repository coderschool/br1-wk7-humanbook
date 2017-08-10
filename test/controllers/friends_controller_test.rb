require 'test_helper'

class FriendsControllerTest < ActionDispatch::IntegrationTest
  test "should get my" do
    get friends_my_url
    assert_response :success
  end

  test "should get friended_by" do
    get friends_friended_by_url
    assert_response :success
  end

end
