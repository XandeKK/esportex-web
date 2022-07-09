require "test_helper"

class SessionControllerTest < ActionDispatch::IntegrationTest
  test "should be get new" do
    get login_path
    assert_response :success
  end

  test "should be login with username" do
    post login_path, params: {
      login: users(:one).username,
      password: "password"
    }
    assert_not_nil session[:user_id]
    assert_equal "login successfully", flash[:notice]
    assert_redirected_to root_path
  end

  test "should be login with email" do
    post login_path, params: {
      login: users(:one).email,
      password: "password"
    }
    assert_not_nil session[:user_id]
    assert_equal "login successfully", flash[:notice]
    assert_redirected_to root_path
  end

  test "should not be login without password" do
    post login_path, params: {
      login: users(:one).email,
    }
    assert_nil session[:user_id]
    assert_equal "Email/password is incorrect.", flash[:alert]
    assert_response :unprocessable_entity
  end

  test "should not be login without username or email" do
    post login_path, params: {
      login: '',
      password: 'password'
    }

    assert_nil session[:user_id]
    assert_equal "Email/password is incorrect.", flash[:alert]
    assert_response :unprocessable_entity
  end

  test 'should be logout' do
    delete logout_path

    assert_nil session[:user_id]
    assert_equal "Logout successfully", flash[:notice]
    assert_redirected_to login_path
  end
end
