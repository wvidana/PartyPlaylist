# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'spec_helper'
require 'rspec/rails'
require 'database_cleaner'

# Requires supporting ruby files
Dir[Rails.root.join("spec/support/*.rb")].sort.each { |f| require f }

# Checks for pending migrations before tests are run.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  #
  # Fer: Not sure yet...
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # Using DatabaseCleaner for this
  config.use_transactional_fixtures = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  config.before(:each) do
    # Slow, but necessary when using Selenium under acceptance tests
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
  end
end

# Register capybara drivers
Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

# Set a default driver
if ENV['BROWSER'].nil?
  DEFAULT_DRIVER = :webkit
else
  requested_driver = ENV['BROWSER'].downcase.to_sym
  if Capybara.drivers.has_key?(requested_driver)
    DEFAULT_DRIVER = requested_driver
  else
    warn "Requested driver #{ENV['BROWSER'].inspect} is not supported by capybara, defaulting to chrome"
    DEFAULT_DRIVER = :chrome
  end
end

Capybara::Webkit.configure do |config|
  config.block_unknown_urls
end

Capybara.configure do |c|
  c.default_wait_time       = 5
  c.ignore_hidden_elements  = true
  c.default_driver          = DEFAULT_DRIVER
  c.javascript_driver       = :firefox
end
