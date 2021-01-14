ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"
require 'vcr'
require 'minitest/autorun'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Add more helper methods to be used by all tests here...
  VCR.configure do |config|
    config.allow_http_connections_when_no_cassette = false
    config.cassette_library_dir = "fixtures/vcr_cassettes"
    config.hook_into :webmock
    config.ignore_localhost = true
  end
end
