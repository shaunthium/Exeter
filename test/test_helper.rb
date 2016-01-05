ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'
Minitest::Reporters.use!(
  Minitest::Reporters::ProgressReporter.new,
  ENV,
  Minitest.backtrace_filter
)

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def log_in_as(user, options = {})
    password = options[:password] || "1"
    remember_me = options[:remember_me] || "1"
    if integration_test?
      post login_path, session: {
        email: user.email,
        password: password,
        remember_me: remember_me
      }
    else
      session[:user_id] = user.id
    end
  end

  # Needed because current_logged_in_user in tests
  # cannot use methods on cookies e.g. .permanent,
  # .signed
  def is_logged_in?
    !session[:user_id].nil?
  end

  private
    def integration_test?
      defined?(post_via_redirect)
    end
end
