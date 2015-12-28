require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
    test "account_activation" do
        james = users(:james)
        james.activation_token = User.new_token
        mail = UserMailer.account_activation(james)
        assert_equal "Account activation", mail.subject
        assert_equal [james.email], mail.to
        assert_equal ["noreply@exeter.com"], mail.from
        assert_match james.name, mail.body.encoded
        assert_match james.activation_token, mail.body.encoded
        assert_match CGI.escape(james.email), mail.body.encoded
    end

  # test "password_reset" do
  #   mail = UserMailer.password_reset
  #   assert_equal "Password reset", mail.subject
  #   assert_equal ["to@example.org"], mail.to
  #   assert_equal ["from@example.com"], mail.from
  #   assert_match "Hi", mail.body.encoded
  # end

end
