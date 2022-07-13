require "test_helper"

class FollowerControllerTest < ActionDispatch::IntegrationTest
  test "should follow user" do
    set_user

    assert_difference("Follower.count") do
      post follow_user_path(users(:three))
    end
    assert_response :success
  end

  test "should not follow user who is already following" do
    set_user

    assert_no_difference("Follower.count") do
      post follow_user_path(users(:two))
    end
    assert_response :success
  end

  test "should unfollow user" do
    set_user

    assert_difference("Follower.count", -1) do
      delete unfollow_user_path(users(:two))
    end
    assert_response :success
  end

  test "should not unfollow user who does not follow" do
    set_user

    assert_no_difference("Follower.count") do
      delete unfollow_user_path(users(:three))
    end
    assert_response :success
  end
end
