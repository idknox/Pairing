# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"

  config.include OmniauthHelpers
  config.include ObjectFactories
  config.include ControllerHelpers, type: :controller
  config.include FeatureHelpers, type: :feature
end

def in_browser(browser_name)
  old_session = Capybara.session_name

  Capybara.session_name = browser_name
  yield

  Capybara.session_name = old_session
end

OmniAuth.config.test_mode = true
