require "test_helper"

class FollowerTest < ActiveSupport::TestCase
  def setup
    @follower = Follower.new(
        user_id: users(:one).id,
        follower_id: users(:two).id,
      )
  end

  test "should be valid" do
    assert @follower.valid?
  end

  test "should be save" do
    assert_difference("Follower.count") do
      assert @follower.save
    end
  end

  test "should be destroy" do
    assert_difference("Follower.count") do
      assert @follower.save
    end

    assert_difference("Follower.count", -1) do
      assert @follower.destroy
    end
  end

  test "should be invalid with non-existent user" do
    @follower.user_id = nil
    @follower.follower_id = nil
    assert @follower.invalid?
  end
end
