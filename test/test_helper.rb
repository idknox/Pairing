ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"
require "minitest/rails/capybara"
require "minitest/pride"

Dir.glob(Rails.root.join("test/support/**/*.rb")).each { |file| require file }

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  fixtures :all

  include OmniauthHelpers
end

OmniAuth.config.test_mode = true