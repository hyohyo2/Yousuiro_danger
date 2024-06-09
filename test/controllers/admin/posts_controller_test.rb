require "test_helper"

class Admin::PostsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get admin_posts_show_url
    assert_response :success
  end
end
