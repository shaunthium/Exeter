# Defines the matching rules for Guard.

guard :minitest, spring: true, all_on_start: false do
    # Runs each test itself when it changes
    watch(%r{^test/(.*)/?(.*)_test\.rb$})
    # Runs all tests when TestHelper changes
    watch('test/test_helper.rb') { 'test' }
    # Runs all integration tests when routes.rb changes
    watch('config/routes.rb')    { integration_tests }

    # Do model test for corresponding model
    watch(%r{^app/models/(.*?)\.rb$}) do |matches|
        model_test(matches[1])
    end
    # Do resource tests for corresponding controller
    watch(%r{^app/controllers/(.*?)_controller\.rb$}) do |matches|
        resource_tests(matches[1])
    end
    # Do integration tests and controller test for corresponding views
    watch(%r{^app/views/([^/]*?)/.*\.html\.erb$}) do |matches|
        [integration_tests(matches[1]), controller_test(matches[1])]
    end
    # Do integration tests, controller tests and helper tests for corresponding helper
    watch(%r{^app/helpers/(.*?)_helper\.rb$}) do |matches|
        [integration_tests(matches[1]), controller_test(matches[1]), helper_test(matches[1])]
    end
    # As SessionsHelper is used extensively,
    # do all integration tests as well as
    # corresponding controller and helper tests
    # if it's changed
    watch('app/helpers/sessions_helper.rb') {
        [integration_tests, 'test/controllers/sessions_controller_test.rb', 'test/helpers/sessions_helper_test.rb']
    }
    # Do all tests if ApplicationController is changed
    watch('app/controllers/application_controller.rb') {
        resource_tests
    }
end

# Returns the integration tests corresponding to the given resource.
def integration_tests(resource = "all")
    if resource == "all"
        Dir["test/integration/*"]
    else
        Dir["test/integration/#{resource}_*.rb"]
    end
end

# Returns the controller tests corresponding to the given resource.
def controller_test(resource = "all")
    if resource == "all"
        Dir["test/controllers/*"]
    else
        Dir["test/controllers/#{resource}_controller_test.rb"]
    end
end

# Returns the model tests corresponding to the given resource.
def model_test(resource = "all")
    if resource == "all"
        Dir["test/models/*"]
    else
        Dir["test/models/#{resource}_test.rb"]
    end
end

def helper_test(resource)
    if resource == "all"
        Dir["test/helpers/*"]
    else
        Dir["test/helpers/#{resource}_helper_test.rb"]
    end
end

# Returns all tests for the given resource.
def resource_tests(resource = "all")
    if resource != "all"
        resource_for_model = resource.to_s.chop
    else
        resource_for_model = "all"
    end
    [integration_tests(resource), controller_test(resource), model_test(resource_for_model), helper_test(resource)]
end

# Guard-Rails supports a lot options with default values:
# daemon: false                        # runs the server as a daemon.
# debugger: false                      # enable ruby-debug gem.
# environment: 'development'           # changes server environment.
# force_run: false                     # kills any process that's holding the listen port before attempting to (re)start Rails.
# pid_file: 'tmp/pids/[RAILS_ENV].pid' # specify your pid_file.
# host: 'localhost'                    # server hostname.
# port: 3000                           # server port number.
# root: '/spec/dummy'                  # Rails' root path.
# server: thin                         # webserver engine.
# start_on_start: true                 # will start the server when starting Guard.
# timeout: 30                          # waits untill restarting the Rails server, in seconds.
# zeus_plan: server                    # custom plan in zeus, only works with `zeus: true`.
# zeus: false                          # enables zeus gem.
# CLI: 'rails server'                  # customizes runner command. Omits all options except `pid_file`!

guard 'rails' do
    watch('Gemfile.lock')
    watch(%r{^(config|lib)/.*})
end
