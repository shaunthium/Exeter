source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'

# Use SASS for stylesheets
gem 'sass-rails', '~> 5.0'

# Use Bootstrap
gem 'bootstrap-sass'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use PostgresSQL as database
gem 'pg'

# Use human-readable strings as route ids
# and obfuscate ids
gem 'friendly_id', '~> 5.1.0'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development do
    # Turns off Rails asset pipeline log
    gem 'quiet_assets'

    # Replaces standard Rails error page with a better
    # one.
    gem 'better_errors'

    # Required for Better Errors gem to use live
    # REPL feature
    gem 'binding_of_caller'

    # Previews mail in browser without sending
    gem 'letter_opener'
end

group :development, :test do

    # Call 'byebug' anywhere in the code to stop execution and get a debugger console
    gem 'byebug'

    # Access an IRB console on exception pages or by using <%= console %> in views
    gem 'web-console', '~> 2.0'

    # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
    gem 'spring'
end

group :test do
    # Required for guard-minitest and guard-rails
    gem 'guard'

    # Runs tests automatically when files change
    # using Guard
    gem 'guard-minitest'

    # Starts Rails server with guard command
    gem 'guard-rails'

    # Custom reporters
    gem 'minitest-reporters'
end

group :production do
    # Needed to deploy app on 12 factor server e.g. Heroku
    gem 'rails_12factor'

    # Use Puma instead of WEBrick in production
    # to handle larger amounts of traffic
    gem 'puma'
end

# Ruby version
ruby '2.2.1'