ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)

require 'minitest/autorun'
require 'minitest/rails'
require 'minitest/pride'
require 'database_cleaner'

require 'mocha/setup'

DatabaseCleaner.strategy = :truncation

class MiniTest::Spec
  # include ActiveRecord::TestFixtures

  alias :method_name :__name__ if defined? :__name__
  # self.fixture_path = File.join(Rails.root, 'test', 'fixtures')

  before :each do
    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end
end

# Uncomment if you want Capybara in accceptance/integration tests
# require "minitest/rails/capybara"

class MiniTest::Rails::ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  # fixtures :all

  # Add more helper methods to be used by all tests here...
end