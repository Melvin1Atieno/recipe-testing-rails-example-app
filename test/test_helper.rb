# frozen_string_literal: true
require "simplecov"
SimpleCov.start
 
ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "faker"
require "database_cleaner"
require "webmock/minitest"
require "vcr"
DatabaseCleaner.strategy = :transaction

# vcr configuration
VCR.configure do |config|
  config.cassette_library_dir = "test/vcr_cassettes/"
  config.hook_into :webmock # or :fakeweb
end


# database cleaner module
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

  def test_example_dot_com
    VCR.use_cassette("synopsis") do
      response = Net::HTTP.get_response(URI('http://www.iana.org/domains/reserved'))
      assert_match /Example domains/, response.body
    end
  end
end
