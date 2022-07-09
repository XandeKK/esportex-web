require "test_helper"

class PasswordResetsControllerTest < ActionDispatch::IntegrationTest
  test "should be get new" do
    get password_resets_path
    assert_response :success
  end

  test "should be get post email" do
    assert_emails 1 do
      post password_resets_path, params: {
        email: users(:one).email
      }
    end
    assert_equal 'E-mail sent with password reset instructions', flash[:notice]
    assert_response :redirect
    assert_redirected_to login_path
  end

  test "should be get edit" do
    user = users(:one)

    get password_resets_edit_path(token: user.password_reset_token)
    assert_response :success
  end

  test "should not be get edit" do
    user = users(:one)

    get password_resets_edit_path(token: 'e mar')
    assert_equal "password reset has expired or don't exist", flash[:alert]
    assert_redirected_to login_path
  end

  test "should be update password" do
    user = users(:one)

    put password_resets_update_path(user.password_reset_token), params: {
      user: {
        password: 132,
        password_confirmation: 132
      }
    }

    assert_redirected_to login_path
    assert_equal 'Password has been reset!', flash[:notice]
  end

  test "should not be update password with expired token" do
    user = users(:two)

    put password_resets_update_path(user.password_reset_token), params: {
      user: {
        password: 132,
        password_confirmation: 132
      }
    }

    assert_redirected_to password_resets_path
    assert_equal 'Password reset has expired', flash[:notice]
  end

end
