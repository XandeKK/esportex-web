require "test_helper"

class SportControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    set_user
    
    get root_path
    assert_response :success
  end
end
