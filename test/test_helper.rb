require 'simplecov'
SimpleCov.start

ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"

# To add Capybara feature tests add `gem "minitest-rails-capybara"`
# to the test group in the Gemfile and uncomment the following:
require "minitest/rails/capybara"
require 'capybara/poltergeist'

# require 'capybara/poltergeist'
# Capybara.javascript_driver = :poltergeist

# Uncomment for awesome colorful output
require "minitest/pride"
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, {phantomjs_logger: File::NULL, js_errors: false})
end


class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  Capybara.javascript_driver = :poltergeist
  Capybara.current_driver = Capybara.javascript_driver

  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  #fixtures :all

  # Add more helper methods to be used by all tests here...
end

