require "test_helper"

class RegistrationControllerTest < ActionDispatch::IntegrationTest
  test "should be get new" do
    get sign_up_path
    assert_response :success
  end

  test "should be create user" do

    assert_difference("User.count") do
      post sign_up_path, params: { user: {
          name: "Alexandre",
          username: "alexandre",
          email: "alexandre@email.com",
          password: "Alexandre",
          password_confirmation: "Alexandre",
          bio: "I'm cool"
        }
      }
    end

    assert_not_nil session[:user_id]
    assert_equal "User created successfully", flash[:notice]
    assert_redirected_to root_path
  end

  test "should not be create user without password" do
    assert_no_difference("User.count") do
      post sign_up_path, params: { user: {
          name: "Alexandre",
          username: "Alexandre",
          email: "alexandre@email.com",
          bio: "I'm cool"
        }
      }
    end
    assert_nil session[:user_id]
    assert_response :unprocessable_entity
  end

  test "should not be create user without name" do
    assert_no_difference("User.count") do
      post sign_up_path, params: { user: {
          username: 'Alexandre',
          email: "alexandre@email.com",
          password: "Alexandre",
          password_confirmation: "Alexandre",
          bio: "I'm cool"
        }
      }
    end
    assert_nil session[:user_id]
    assert_response :unprocessable_entity
  end

  test "should not be create user without username" do
    assert_no_difference("User.count") do
      post sign_up_path, params: { user: {
          name: 'Alexandre',
          email: "alexandre@email.com",
          password: "Alexandre",
          password_confirmation: "Alexandre",
          bio: "I'm cool"
        }
      }
    end
    assert_nil session[:user_id]
    assert_response :unprocessable_entity
  end

  test "should not be create user without email" do
    assert_no_difference("User.count") do
      post sign_up_path, params: { user: {
          name: "Alexandre",
          username: "Alexandre",
          password: "Alexandre",
          password_confirmation: "Alexandre",
          bio: "I'm cool"
        }
      }
    end
    assert_nil session[:user_id]
    assert_response :unprocessable_entity
  end
end
