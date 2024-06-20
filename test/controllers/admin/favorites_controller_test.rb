require "test_helper"

class Admin::FavoritesControllerTest < ActionDispatch::IntegrationTest
  test "should get favorites_post" do
    get admin_favorites_favorites_post_url
    assert_response :success
  end
end
