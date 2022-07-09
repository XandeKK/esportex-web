require "test_helper"

class MapControllerTest < ActionDispatch::IntegrationTest
  test "should be get show" do
    set_user
    
    get map_games_path
    assert_response :success
  end
end
