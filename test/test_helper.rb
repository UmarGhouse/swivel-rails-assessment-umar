ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require 'mocha/minitest'

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    # Doorkeeper token stub
    def sign_in user
      token = Doorkeeper::AccessToken.new(resource_owner_id: user.id)
      ApplicationController.any_instance.stubs(:doorkeeper_token).returns(token)
    end

    # Searchkick - reindex and disable callbacks
    Vertical.reindex
    Category.reindex
    Course.reindex

    Searchkick.disable_callbacks
  end
end
