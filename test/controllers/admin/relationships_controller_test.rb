require "test_helper"

class Admin::RelationshipsControllerTest < ActionDispatch::IntegrationTest
  test "should get followings" do
    get admin_relationships_followings_url
    assert_response :success
  end

  test "should get followers" do
    get admin_relationships_followers_url
    assert_response :success
  end
end
