# frozen_string_literal: true
require "simplecov"
SimpleCov.start
 
ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "faker"
require "database_cleaner"
DatabaseCleaner.strategy = :transaction

module AroundEachTest
  def before_setup
   super
   DatabaseCleaner.start
  end
  def after_teardown
   super
   DatabaseCleaner.clean
  end
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  include FactoryBot::Syntax::Methods
  # Add more helper methods to be used by all tests here...
  include AroundEachTest
end
