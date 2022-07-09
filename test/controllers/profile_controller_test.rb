require "test_helper"

class ProfileControllerTest < ActionDispatch::IntegrationTest
  test "should be get show" do
    set_user

    get profile_path(users(:one).username)
    assert_response :success
  end

  test "should not be get show" do
    set_user

    get profile_path("dont_exist")
    assert_equal "User don't exist", flash[:alert]
    assert_redirected_to root_path
  end

  test "should be get edit" do
    set_user

    get edit_profile_path
    assert_response :success
  end

  test "should be update user" do 
    set_user

    put update_profile_path, params: { user: {
        name: "Alexandre",
        username: "alexandre",
        email: "alexandre@email.com",
        password: "Alexandre",
        password_confirmation: "Alexandre",
        bio: "I'm cool"
      }
    }

    assert_response :redirect
    assert_equal "Successfully updated", flash[:notice]
    assert_redirected_to profile_path('alexandre')
  end

  test "should not be update user with existing username or email" do 
    set_user

    put update_profile_path, params: { user: {
        name: "Alexandre",
        username: "friend",
        email: "frind@examples.com",
        password: "Alexandre",
        password_confirmation: "Alexandre",
        bio: "I'm cool"
      }
    }

    assert_response :unprocessable_entity
  end

  test "should be destroy user" do 
    set_user

    assert_difference('User.count', -1) do
      delete destroy_user_path
    end

    assert_equal "Successfully deleted", flash[:notice]
    assert_redirected_to login_path
  end
end
