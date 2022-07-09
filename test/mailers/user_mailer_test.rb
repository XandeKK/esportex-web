require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "invite" do
    # Create the email and store it for further assertions
    email = UserMailer.with(user: users(:one)).forgot_password

    # Send the email, then test that it got queued
    assert_emails 1 do
      email.deliver_now
    end

    # Test the body of the sent email contains what we expect it to
    assert_equal ["from@example.com"], email.from
    assert_equal ["fried@example.com"], email.to
    assert_equal "Reset password instructions", email.subject
  end
end
