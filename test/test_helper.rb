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
      if integration_test?
          post login_path, session: {
              email: user.email,
              password: password
          }
      else
          session[:user_id] = user.id
      end
  end

  private
    def integration_test?
        defined?(post_via_redirect)
    end
end
