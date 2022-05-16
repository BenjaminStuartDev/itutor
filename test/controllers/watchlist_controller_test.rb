require "test_helper"

class WatchlistControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get watchlist_index_url
    assert_response :success
  end

  test "should get create" do
    get watchlist_create_url
    assert_response :success
  end

  test "should get destroy" do
    get watchlist_destroy_url
    assert_response :success
  end
end
