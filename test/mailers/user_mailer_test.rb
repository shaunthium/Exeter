require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  def setup
    @james = users(:james)
  end
  test "account_activation" do
    @james.activation_token = User.new_token
    mail = UserMailer.account_activation(@james)
    assert_equal "Account activation", mail.subject
    assert_equal [@james.email], mail.to
    assert_equal ["noreply@exeter.com"], mail.from
    assert_match @james.name, mail.body.encoded
    assert_match @james.activation_token, mail.body.encoded
    assert_match CGI.escape(@james.email), mail.body.encoded
  end

  test "password_reset" do
    @james.reset_token = User.new_token
    mail = UserMailer.password_reset(@james)
    assert_equal "Password reset", mail.subject
    assert_equal [@james.email], mail.to
    assert_equal ["noreply@exeter.com"], mail.from
    assert_match @james.reset_token, mail.body.encoded
    assert_match CGI.escape(@james.email), mail.body.encoded
  end
end
